#!/usr/bin/env ruby
##[>] 🤖🤖
#[why] terraform only warns on a value for an undeclared variable, so a typo'd key would create
#   nothing and pass. This turns that warning into the failure the generated files need.
require 'json'
require 'net/http'
require 'set'
require 'uri'
require_relative 'tfvars'
ROOT = File.expand_path('..', __dir__)
CONSUMER_GLOB = 'live/consumers/**/generated.auto.tfvars'.freeze
DOWNGRADE_MARK = 'pin-downgrade'.freeze
LOCKFILE = '.repo/upstream.env'.freeze

def declared(module_name)
  File.read(File.join(ROOT, 'modules', module_name, 'main.tf'), encoding: 'UTF-8')
      .scan(/^variable "([A-Z][A-Z0-9_]*)"/).flatten.to_set
end

def rel(file)
  file.delete_prefix("#{ROOT}/")
end

def semver_key(version)
  m = version.to_s.scan(/v(\d+)\.(\d+)\.(\d+)/).last
  m ? m.map(&:to_i) : [-1]
end

def git(*args)
  out = IO.popen(['git', '-C', ROOT, *args], err: %i[child out], &:read)
  $?.success? ? out : nil
end

def base_sha
  sha = ENV['CI_MERGE_REQUEST_DIFF_BASE_SHA'].to_s
  sha = ENV['CI_COMMIT_BEFORE_SHA'].to_s if sha.empty?
  return nil if sha.empty? || sha.match?(/\A0+\z/)

  git('cat-file', '-e', sha) || git('fetch', '--quiet', '--depth=1', 'origin', sha)
  sha
end

def keys_at(sha, file)
  body = git('show', "#{sha}:#{rel(file)}")
  body ? body.scan(Tfvars::ASSIGNMENT).select { |key, _| key.match?(/\A[A-Z][A-Z0-9_]*\z/) }.to_h : {}
end

def downgrade_marked?
  message = ENV['CI_COMMIT_MESSAGE'].to_s
  message = git('log', '-1', '--format=%B').to_s if message.empty?
  message.include?(DOWNGRADE_MARK)
end

def lockfile_of(project)
  token = ENV['CONSUMER_READ_TOKEN'].to_s
  return nil if token.empty?

  uri = URI("#{ENV.fetch('CI_API_V4_URL', 'https://gitlab.com/api/v4')}/projects/#{URI.encode_www_form_component(project)}" \
            "/repository/files/#{URI.encode_www_form_component(LOCKFILE)}/raw?ref=main")
  res = Net::HTTP.get_response(uri, 'PRIVATE-TOKEN' => token)
  return nil unless res.is_a?(Net::HTTPSuccess)

  res.body.lines.map(&:strip).reject { |l| l.empty? || l.start_with?('#') }.map { |l| l.split('=', 2) }.to_h
end

def unknown_key_failures
  { 'consumer-vars' => CONSUMER_GLOB, 'producer-vars' => 'live/producers/generated.auto.tfvars' }.flat_map do |mod, glob|
    known = declared(mod)
    Dir.glob(File.join(ROOT, glob)).sort.filter_map do |file|
      unknown = Tfvars.keys(file).keys.reject { |k| known.include?(k) }
      "#{rel(file)}: #{mod} declares no #{unknown.join(', ')}" unless unknown.empty?
    end
  end
end

def changed_since(base, files)
  return files if base.nil?

  files.select { |file| keys_at(base, file) != Tfvars.keys(file) }
end

def downgrade_failures(base)
  return [] if base.nil? || downgrade_marked?

  changed_since(base, Dir.glob(File.join(ROOT, CONSUMER_GLOB)).sort).flat_map do |file|
    held = keys_at(base, file)
    Tfvars.keys(file).filter_map do |key, version|
      next unless held[key] && (semver_key(version) <=> semver_key(held[key])).negative?

      "#{rel(file)}: #{key} #{held[key]} -> #{version} lowers a consumer pin, put #{DOWNGRADE_MARK} in the commit message if meant"
    end
  end
end

def lockfile_failures(base)
  changed_since(base, Dir.glob(File.join(ROOT, CONSUMER_GLOB)).sort).flat_map do |file|
    project = Tfvars.scope(file).fetch('project')
    lockfile = lockfile_of(project)
    if lockfile.nil?
      warn "#{rel(file)}: #{project} has no readable #{LOCKFILE} on main, skipped"
      next []
    end
    Tfvars.keys(file).filter_map do |key, version|
      "#{rel(file)}: #{key} #{version} differs from #{LOCKFILE} on #{project} main (#{lockfile[key] || 'absent'})" if lockfile[key] != version
    end
  end
end

base = base_sha
failures = unknown_key_failures + downgrade_failures(base) + lockfile_failures(base)

if failures.empty?
  puts 'every generated tfvars names only declared variables, lowers no consumer pin, matches every lockfile'
  exit 0
end

warn(*failures)
exit 1
##[<] 🤖🤖

#!/usr/bin/env ruby
##[>] 🤖🤖
#[why] this repo is where desired lives: the tfvars it applies ARE the version each scope is meant
#   to hold. automation cannot derive them, its aggregate runs with no GitLab token. It reports the
#   values only, keyed by scope: shaping them into edges needs the graph, which automation owns.
require 'json'
require_relative 'tfvars'

module DesiredVersions
  ROOT = File.expand_path('..', __dir__)
  PRODUCERS_FILE = 'live/producers/generated.auto.tfvars'.freeze

  # Every applied target, keyed by consumer repo, with the group's under "group".
  def self.call(root: ROOT)
    consumers = Dir.glob(File.join(root, 'live/consumers/**/generated.auto.tfvars')).sort.to_h do |path|
      [Tfvars.scope(path).fetch('project').delete_prefix('konradodwrot/'), Tfvars.keys(path)]
    end
    consumers.merge('group' => Tfvars.keys(File.join(root, PRODUCERS_FILE)))
  end

  def self.moved(before:, root: ROOT)
    return [] if before.to_s.empty? || before.match?(/\A0+\z/)

    held = producers_at(before, root: root)
    return [] if held.nil?

    Tfvars.keys(File.join(root, PRODUCERS_FILE)).filter_map do |key, version|
      { 'key' => key, 'from' => held[key], 'to' => version } if held[key] != version
    end
  end

  def self.producers_at(sha, root:)
    body = IO.popen(['git', '-C', root, 'show', "#{sha}:#{PRODUCERS_FILE}"], err: File::NULL, &:read)
    return nil unless $?.success?

    body.scan(Tfvars::ASSIGNMENT).select { |key, _| key.match?(/\A[A-Z][A-Z0-9_]*\z/) }.to_h
  end

  def self.events(before:, root: ROOT)
    events = [{ 'type' => 'desired-versions.applied', 'details' => { 'versions' => call(root: root) } }]
    variables = moved(before: before, root: root)
    events << { 'type' => 'ci-variable.updated', 'details' => { 'variables' => variables } } unless variables.empty?
    events
  end
end

if $PROGRAM_NAME == __FILE__
  out = ARGV[0] || 'extra-events.json'
  events = DesiredVersions.events(before: ENV['CI_COMMIT_BEFORE_SHA'])
  File.write(out, JSON.generate(events))
  warn "wrote #{out}: #{events.map { |e| e['type'] }.join(' ')}"
end
##[<] 🤖🤖

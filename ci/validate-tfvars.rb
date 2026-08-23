#!/usr/bin/env ruby
##[>] 🤖🤖
#[why] terraform only warns on a value for an undeclared variable, so a typo'd key would create
#   nothing and pass. This turns that warning into the failure the generated files need.
require 'set'
require_relative 'tfvars'
ROOT = File.expand_path('..', __dir__)

def declared(module_name)
  File.read(File.join(ROOT, 'modules', module_name, 'main.tf')).scan(/^variable "([A-Z][A-Z0-9_]*)"/).flatten.to_set
end

def keys_in(path)
  Tfvars.keys(path).keys
end

failures = []
{ 'consumer-vars' => 'live/consumers/**/generated.auto.tfvars',
  'producer-vars' => 'live/producers/generated.auto.tfvars' }.each do |mod, glob|
  known = declared(mod)
  Dir.glob(File.join(ROOT, glob)).sort.each do |file|
    unknown = keys_in(file).reject { |k| known.include?(k) }
    next if unknown.empty?

    failures << "#{file.delete_prefix("#{ROOT}/")}: #{mod} declares no #{unknown.join(', ')}"
  end
end

if failures.empty?
  puts 'every generated tfvars names only declared variables'
  exit 0
end

warn(*failures)
exit 1
##[<] 🤖🤖

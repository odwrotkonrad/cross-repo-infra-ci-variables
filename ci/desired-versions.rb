#!/usr/bin/env ruby
##[>] 🤖🤖
#[why] this repo is where desired lives: the tfvars it applies ARE the version each scope is meant
#   to hold. automation cannot derive them, its aggregate runs with no GitLab token. It reports the
#   values only, keyed by scope: shaping them into edges needs the graph, which automation owns.
require 'json'
require_relative 'tfvars'

module DesiredVersions
  ROOT = File.expand_path('..', __dir__)

  # Every applied target, keyed by consumer repo, with the group's under "group".
  def self.call(root: ROOT)
    consumers = Dir.glob(File.join(root, 'live/consumers/**/generated.auto.tfvars')).sort.to_h do |path|
      [Tfvars.scope(path).fetch('project').delete_prefix('konradodwrot/'), Tfvars.keys(path)]
    end
    consumers.merge('group' => Tfvars.keys(File.join(root, 'live/producers/generated.auto.tfvars')))
  end
end

if $PROGRAM_NAME == __FILE__
  out = ARGV[0] || 'extra-events.json'
  versions = DesiredVersions.call
  File.write(out, JSON.generate([{ 'type' => 'desired-versions.applied', 'details' => { 'versions' => versions } }]))
  warn "wrote #{out}: desired-versions.applied (#{versions.size} scopes)"
end
##[<] 🤖🤖

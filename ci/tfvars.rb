##[>] 🤖🤖
# Tfvars reads the generated.auto.tfvars files: the `KEY = "value"` shape and nothing else.
module Tfvars
  ASSIGNMENT = /^(\w+)\s*=\s*"([^"]*)"/.freeze

  # The uppercase variable assignments, keyed by name.
  def self.keys(path)
    File.readlines(path, encoding: 'UTF-8').filter_map { |line| line.match(ASSIGNMENT)&.captures }
        .select { |key, _| key.match?(/\A[A-Z][A-Z0-9_]*\z/) }.to_h
  end

  # The lowercase scope assignments naming which project or group the file targets.
  def self.scope(path)
    File.readlines(path, encoding: 'UTF-8').filter_map { |line| line.match(ASSIGNMENT)&.captures }
        .reject { |key, _| key.match?(/\A[A-Z][A-Z0-9_]*\z/) }.to_h
  end
end
##[<] 🤖🤖

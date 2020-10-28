# frozen_string_literal: true

require 'grape'
require 'erb'
require 'yaml'
require 'dry/configurable'
require_relative 'environment'

# Config class
class Environment
  extend Dry::Configurable

  CONFIG_PATHS = Dir[File.join(__dir__, '../../config', '*.yml')]
  CONFIG_PATHS.each do |path|
    config_key = File.basename(path, '.*')
    template = ERB.new(File.read(path)).result
    config_value = YAML.safe_load(template)
    setting(config_key.to_sym, config_value)
  end
end

# frozen_string_literal: true

require 'sequel'
require 'i18n'
require 'logger'
require 'dry/system/container'
require_relative 'environment'

# Application Containera
class Container < Dry::System::Container
  configure do |config|
    config.root = Pathname('./api')
    config.auto_register = 'components'
  end

  register :production?, memoize: true do
    ENV.fetch('RACK_ENV', 'development') == 'production'
  end

  register :test?, memoize: true do
    ENV.fetch('RACK_ENV', 'development') == 'test'
  end

  register :config do
    Environment.config
  end

  register :database, memoize: true do
    if self[:test?]
      Sequel.sqlite
    else
      database_config = self[:config].application['database']
      Sequel.connect(database_config['dsn'])
    end
  end

  register :log, memoize: true do
    logger_config = self[:config].application['logger']
    log = Logger.new(File.join(__dir__, '../..', logger_config['output']))
    log.level = logger_config['level']
    log
  end

  load_paths!('components')
end

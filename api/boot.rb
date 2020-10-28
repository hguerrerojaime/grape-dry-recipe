# frozen_string_literal: true

require 'pry' unless ENV.fetch('RACK_ENV', 'development') == 'production'
require 'json'
require_relative 'lib/types'
require_relative 'lib/import'
require_relative 'routes/root'
require_relative 'helpers/data_helper'
require_relative 'helpers/business_class'

class Object
  def log
    Container.resolve(:log)
  end
end

require 'singleton'
require_relative 'db/database_tasks'
class Sandbox
  include Singleton
  include DatabaseTasks
end
Sandbox.instance.run_migrations
# Sandbox.instance.run_seeds

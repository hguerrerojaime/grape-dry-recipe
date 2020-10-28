# frozen_string_literal: true

require 'sequel'
require 'sequel/extensions/migration'
require 'sequel/extensions/seed'
require './api/lib/container'

module DatabaseTasks
  def run_migrations(db = Container.resolve(:database))
    log.info('Running migrations...')
    migrations_path = File.join(__dir__, 'migrations')
    Sequel::Migrator.run(db, migrations_path, use_transactions: true)
    log.info('Migrations completed successfully!')
  end

  def run_seeds(db = Container.resolve(:database))
    log.info('Running seeds...')
    Sequel.extension(:seed)
    seeds_path = File.join(__dir__, 'seeds')
    Sequel::Seeder.apply(db, seeds_path)
    log.info('Seeds completed successfully!')
  end
end

# frozen_string_literal: true

require './api/db/database_tasks'

namespace :db do
  include DatabaseTasks

  desc 'Run migrations'
  task :migrate, [:conn] do |_, args|
    db = if args[:conn]
           Sequel.connect(args[:conn])
         else
           Container.resolve(:database)
         end
    run_migrations(db)
  end

  desc 'Run seeds'
  task :seed, [:conn] do |_, args|
    db = if args[:conn]
           Sequel.connect(args[:conn])
         else
           Container.resolve(:database)
         end
    run_seeds(db)
  end
end

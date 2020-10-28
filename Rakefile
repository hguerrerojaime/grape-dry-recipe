# frozen_string_literal: true

require 'rake/testtask'

Rake.add_rakelib ENV['RAKE_TASKS'] unless ENV['RAKE_TASKS'].nil?

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.warning = false
  t.test_files = FileList['test/**/*_test.rb']
end

task :rubocop do
  sh 'rubocop'
end

task release: %i[rubocop test]
task default: :release

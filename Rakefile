require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task default: [:spec]

desc 'Runs code coverage'
task :rcov do
  ENV['COVERAGE'] = 'true'
  Rake::Task[:spec].invoke
end

require 'rspec/core/rake_task'
require 'cucumber'
require 'cucumber/rake/task'

desc "Run unit tests"
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/**/*.rb'
end

desc "Run acceptance tests"
Cucumber::Rake::Task.new(:features)

task :default => [ :spec, :features ]

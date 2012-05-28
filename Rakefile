require 'rspec/core/rake_task'

desc "Run unit tests"
RSpec::Core::RakeTask.new('spec') do |t|
  t.pattern = 'spec/**/*.rb'
end

desc "Run acceptance tests"
task :features do
  system("cucumber") || exit(1)
end

task :default => [ :spec, :features ]

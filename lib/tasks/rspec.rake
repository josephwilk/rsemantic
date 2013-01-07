require 'rspec/core/rake_task'

desc 'Default: run specs.'
task :default => [:spec, :integration]

desc "Run specs"
RSpec::Core::RakeTask.new 

RSpec::Core::RakeTask.new(:integration) do |t|
  t.pattern = 'spec_integration/*_spec.rb'
end

desc "Generate code coverage"
RSpec::Core::RakeTask.new(:coverage) do |t|
  t.rcov = true
  t.rcov_opts = ['--exclude', 'spec']
end
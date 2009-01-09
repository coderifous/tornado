require 'rake'
require 'rake/testtask'
require 'rcov/rcovtask'

desc 'Run test coverage.'
Rcov::RcovTask.new do |t|
  t.libs << "test" << "test/helpers"
  t.pattern    = 'test/test_*.rb'
  t.output_dir = 'rcov'
  t.verbose    = true
end

Rake::TestTask.new do |t|
  t.libs << "test" << "test/helpers"
  t.test_files = FileList['test/test_*.rb']
  t.verbose = true
end


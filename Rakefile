%w[rubygems rake rake/clean fileutils].each { |f| require f }
require File.dirname(__FILE__) + '/lib/tornado'
require 'echoe'
require 'rake/testtask'
require 'rcov/rcovtask'
 
Echoe.new('tornado', Tornado::VERSION) do |p|
  p.description = "Ruby DSL for easily launching, arranging and doing other simple tasks with Mac OS X applications."
  p.url = "http://github.com/coderifous/tornado"
  p.author = "Jim Garvin"
  p.email = "jim at thegarvin dot com"
  p.ignore_pattern = ["rdoc/*", "rcov/*"]
  p.development_dependencies = []
  p.runtime_dependencies = ['rb-appscript >=0.5.1']
end

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


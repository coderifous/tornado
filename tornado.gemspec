Gem::Specification.new do |s|
  s.name = %q{tornado}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jim Garvin"]
  s.date = %q{2009-01-10}
  s.description = %q{Ruby DSL for easily launching, arranging and doing other simple tasks with Mac OS X applications.}
  s.email = %q{jim at thegarvin dot com}
  s.extra_rdoc_files = ["lib/applications/finder.rb", "lib/applications/firefox.rb", "lib/applications/safari.rb", "lib/applications/terminal.rb", "lib/applications/textmate.rb", "lib/generic_application.rb", "lib/osx.rb", "lib/tornado.rb", "README.markdown"]
  s.files = ["examples/tornado-cubenot_site.rb", "lib/applications/finder.rb", "lib/applications/firefox.rb", "lib/applications/safari.rb", "lib/applications/terminal.rb", "lib/applications/textmate.rb", "lib/generic_application.rb", "lib/osx.rb", "lib/tornado.rb", "Manifest", "Rakefile", "README.markdown", "test/helpers/test_helpers.rb", "test/test_application_finder.rb", "test/test_application_osx.rb", "test/test_application_terminal.rb", "test/test_generic_application.rb", "test/test_tornado.rb", "tornado.gemspec"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/coderifous/tornado}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Tornado", "--main", "README.markdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{tornado}
  s.rubygems_version = %q{1.2.0}
  s.summary = %q{Ruby DSL for easily launching, arranging and doing other simple tasks with Mac OS X applications.}
  s.test_files = ["test/helpers/test_helpers.rb", "test/test_application_finder.rb", "test/test_application_osx.rb", "test/test_application_terminal.rb", "test/test_generic_application.rb", "test/test_tornado.rb"]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if current_version >= 3 then
      s.add_runtime_dependency(%q<rb-appscript>, [">= 0.5.1"])
    else
      s.add_dependency(%q<rb-appscript>, [">= 0.5.1"])
    end
  else
    s.add_dependency(%q<rb-appscript>, [">= 0.5.1"])
  end
end

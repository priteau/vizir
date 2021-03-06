# Generated by jeweler
# DO NOT EDIT THIS FILE
# Instead, edit Jeweler::Tasks in Rakefile, and run `rake gemspec`
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vizir}
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pierre Riteau"]
  s.date = %q{2009-08-06}
  s.default_executable = %q{vizir}
  s.description = %q{Vizir is a simple Ruby script for Mac OS X that monitors your interactive jobs on Grid'5000. It triggers Growl notifications when your reservations are going to terminate, allowing you to save your work and/or your deployed environments.}
  s.email = %q{priteau@gmail.com}
  s.executables = ["vizir"]
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "bin/vizir",
     "lib/vizir.rb",
     "test/test_helper.rb",
     "test/test_vizir.rb",
     "vizir.gemspec"
  ]
  s.homepage = %q{http://priteau.github.com/vizir/}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{vizir}
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Growl notifications for Grid'5000 jobs}
  s.test_files = [
    "test/test_helper.rb",
     "test/test_vizir.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<eventmachine>, [">= 0"])
      s.add_runtime_dependency(%q<growlnotifier>, [">= 0"])
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<net-ssh-gateway>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
    else
      s.add_dependency(%q<eventmachine>, [">= 0"])
      s.add_dependency(%q<growlnotifier>, [">= 0"])
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<net-ssh-gateway>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
    end
  else
    s.add_dependency(%q<eventmachine>, [">= 0"])
    s.add_dependency(%q<growlnotifier>, [">= 0"])
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<net-ssh-gateway>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
  end
end

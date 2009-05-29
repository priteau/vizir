# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{vizir}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pierre Riteau"]
  s.date = %q{2009-05-29}
  s.default_executable = %q{vizir}
  s.email = %q{pierre.riteau@gmail.com}
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
     "test/vizir_test.rb"
  ]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/priteau/vizir}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Growl notifications for Grid'5000 jobs}
  s.test_files = [
    "test/test_helper.rb",
     "test/vizir_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<json>, [">= 0"])
      s.add_runtime_dependency(%q<net-ssh-gateway>, [">= 0"])
      s.add_runtime_dependency(%q<rest-client>, [">= 0"])
      s.add_runtime_dependency(%q<ruby-growl>, [">= 0"])
    else
      s.add_dependency(%q<json>, [">= 0"])
      s.add_dependency(%q<net-ssh-gateway>, [">= 0"])
      s.add_dependency(%q<rest-client>, [">= 0"])
      s.add_dependency(%q<ruby-growl>, [">= 0"])
    end
  else
    s.add_dependency(%q<json>, [">= 0"])
    s.add_dependency(%q<net-ssh-gateway>, [">= 0"])
    s.add_dependency(%q<rest-client>, [">= 0"])
    s.add_dependency(%q<ruby-growl>, [">= 0"])
  end
end

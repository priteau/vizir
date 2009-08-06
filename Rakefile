require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "vizir"
    gem.summary = "Growl notifications for Grid'5000 jobs"
    gem.description = %Q{Vizir is a simple Ruby script for Mac OS X that monitors your interactive jobs on Grid'5000. It triggers Growl notifications when your reservations are going to terminate, allowing you to save your work and/or your deployed environments.}
    gem.email = "pierre.riteau@gmail.com"
    gem.homepage = "http://github.com/priteau/vizir"
    gem.authors = ["Pierre Riteau"]
    gem.rubyforge_project = "vizir"
    gem.add_dependency "eventmachine"
    gem.add_dependency "growlnotifier"
    gem.add_dependency "json"
    gem.add_dependency "net-ssh-gateway"
    gem.add_dependency "rest-client"
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end

  Jeweler::RubyforgeTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

begin
  require 'rcov/rcovtask'
  Rcov::RcovTask.new do |test|
    test.libs << 'test'
    test.pattern = 'test/**/test_*.rb'
    test.verbose = true
  end
rescue LoadError
  task :rcov do
    abort "RCov is not available. In order to run rcov, you must: sudo gem install spicycode-rcov"
  end
end


task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "vizir #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


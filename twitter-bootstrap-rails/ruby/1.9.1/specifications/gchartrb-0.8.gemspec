# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gchartrb"
  s.version = "0.8"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Deepak Jois"]
  s.date = "2008-03-19"
  s.description = "Visit http://code.google.com/p/gchartrb to track development regarding gchartrb.  == FEATURES:  * Provides an object oriented interface in Ruby to create Google Chart URLs for charts.  == INSTALL:  === Ruby Gem:"
  s.email = "deepak.jois@gmail.com"
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "Manifest.txt", "README.txt"]
  s.homepage = "http://code.google.com/p/gchartrb"
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "gchartrb"
  s.rubygems_version = "1.8.24"
  s.summary = "Ruby Wrapper for the Google Chart API"

  if s.respond_to? :specification_version then
    s.specification_version = 2

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end

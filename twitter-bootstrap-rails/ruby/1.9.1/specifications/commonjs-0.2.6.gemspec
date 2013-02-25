# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "commonjs"
  s.version = "0.2.6"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Charles Lowell"]
  s.date = "2012-04-24"
  s.description = "Host CommonJS JavaScript environments in Ruby"
  s.email = ["cowboyd@thefrontside.net"]
  s.homepage = "http://github.com/cowboyd/commonjs.rb"
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Provide access to your Ruby and Operating System runtime via the commonjs API"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<rspec>, [">= 0"])
    else
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<rspec>, [">= 0"])
    end
  else
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<rspec>, [">= 0"])
  end
end

# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "net-ldap"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Francis Cianfrocca", "Emiel van de Laar", "Rory O'Connell", "Kaspar Schiess", "Austin Ziegler"]
  s.date = "2012-02-15"
  s.description = "Net::LDAP for Ruby (also called net-ldap) implements client access for the\nLightweight Directory Access Protocol (LDAP), an IETF standard protocol for\naccessing distributed directory services. Net::LDAP is written completely in\nRuby with no external dependencies. It supports most LDAP client features and a\nsubset of server features as well.\n\nNet::LDAP has been tested against modern popular LDAP servers including\nOpenLDAP and Active Directory. The current release is mostly compliant with\nearlier versions of the IETF LDAP RFCs (2251\u{2013}2256, 2829\u{2013}2830, 3377, and 3771).\nOur roadmap for Net::LDAP 1.0 is to gain full <em>client</em> compliance with\nthe most recent LDAP RFCs (4510\u{2013}4519, plus portions of 4520\u{2013}4532)."
  s.email = ["blackhedd@rubyforge.org", "gemiel@gmail.com", "rory.ocon@gmail.com", "kaspar.schiess@absurd.li", "austin@rubyforge.org"]
  s.extra_rdoc_files = ["Manifest.txt", "Contributors.rdoc", "Hacking.rdoc", "History.rdoc", "License.rdoc", "README.rdoc"]
  s.files = ["Manifest.txt", "Contributors.rdoc", "Hacking.rdoc", "History.rdoc", "License.rdoc", "README.rdoc"]
  s.homepage = "http://rubyldap.com/"
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubyforge_project = "net-ldap"
  s.rubygems_version = "1.8.24"
  s.summary = "Net::LDAP for Ruby (also called net-ldap) implements client access for the Lightweight Directory Access Protocol (LDAP), an IETF standard protocol for accessing distributed directory services"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe-git>, ["~> 1"])
      s.add_development_dependency(%q<hoe-gemspec>, ["~> 1"])
      s.add_development_dependency(%q<metaid>, ["~> 1"])
      s.add_development_dependency(%q<flexmock>, ["~> 0.9.0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 2.13"])
    else
      s.add_dependency(%q<hoe-git>, ["~> 1"])
      s.add_dependency(%q<hoe-gemspec>, ["~> 1"])
      s.add_dependency(%q<metaid>, ["~> 1"])
      s.add_dependency(%q<flexmock>, ["~> 0.9.0"])
      s.add_dependency(%q<rspec>, ["~> 2.0"])
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 2.13"])
    end
  else
    s.add_dependency(%q<hoe-git>, ["~> 1"])
    s.add_dependency(%q<hoe-gemspec>, ["~> 1"])
    s.add_dependency(%q<metaid>, ["~> 1"])
    s.add_dependency(%q<flexmock>, ["~> 0.9.0"])
    s.add_dependency(%q<rspec>, ["~> 2.0"])
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 2.13"])
  end
end

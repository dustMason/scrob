# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{itunes-library}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Joshua Peek"]
  s.date = %q{2011-06-11}
  s.description = %q{    A Ruby library that makes it easy to dig around your iTunes Library metadata.
}
  s.email = %q{josh@joshpeek.com}
  s.homepage = %q{https://github.com/josh/itunes-library}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Wrapper around iTunes Library.xml}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<plist>, [">= 0"])
    else
      s.add_dependency(%q<plist>, [">= 0"])
    end
  else
    s.add_dependency(%q<plist>, [">= 0"])
  end
end

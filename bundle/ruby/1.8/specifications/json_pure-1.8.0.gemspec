# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{json_pure}
  s.version = "1.8.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Florian Frank"]
  s.date = %q{2013-05-13}
  s.description = %q{This is a JSON implementation in pure Ruby.}
  s.email = %q{flori@ping.de}
  s.files = ["./tests/test_json.rb", "./tests/test_json_addition.rb", "./tests/test_json_encoding.rb", "./tests/test_json_fixtures.rb", "./tests/test_json_generate.rb", "./tests/test_json_generic_object.rb", "./tests/test_json_string_matching.rb", "./tests/test_json_unicode.rb"]
  s.homepage = %q{http://flori.github.com/json}
  s.licenses = ["Ruby"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{JSON Implementation for Ruby}
  s.test_files = ["./tests/test_json.rb", "./tests/test_json_addition.rb", "./tests/test_json_encoding.rb", "./tests/test_json_fixtures.rb", "./tests/test_json_generate.rb", "./tests/test_json_generic_object.rb", "./tests/test_json_string_matching.rb", "./tests/test_json_unicode.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<permutation>, [">= 0"])
      s.add_development_dependency(%q<sdoc>, ["~> 0.3.16"])
      s.add_development_dependency(%q<rake>, ["~> 0.9.2"])
    else
      s.add_dependency(%q<permutation>, [">= 0"])
      s.add_dependency(%q<sdoc>, ["~> 0.3.16"])
      s.add_dependency(%q<rake>, ["~> 0.9.2"])
    end
  else
    s.add_dependency(%q<permutation>, [">= 0"])
    s.add_dependency(%q<sdoc>, ["~> 0.3.16"])
    s.add_dependency(%q<rake>, ["~> 0.9.2"])
  end
end

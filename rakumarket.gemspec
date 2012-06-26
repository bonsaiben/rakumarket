require File.expand_path('../lib/rakumarket/version', __FILE__)

Gem::Specification.new do |s|
  s.name = %q{rakumarket}
  s.version = Rakumarket::VERSION
  s.platform = Gem::Platform::RUBY
  s.required_rubygems_version = ">= 1.3.6"
  s.authors = ["Benjamin Sullivan"]
  s.email = %q{bsullivan2@gmail.com}
  s.homepage = %q{http://github.com/bonsaiben/rakumarket}
  s.summary = %q{A reader-friendly Ruby abstraction of the Rakuten Market API}
  s.description = %q{A reader-friendly Ruby abstraction of the Rakuten Market API}

  s.required_rubygems_version = ">= 1.3.6"

  s.add_dependency "nibbler", "~> 1.3.0"
  s.add_dependency "httparty", ">= 0.1.0"
  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", "~> 2.6"
  s.add_development_dependency "webmock"
  s.add_development_dependency "vcr"

  s.files = `git ls-files`.split("\n")
  s.require_path = 'lib'

end


# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sass-rails-source-maps/version'

Gem::Specification.new do |gem|
  gem.name          = "sass-rails-source-maps"
  gem.version       = SassRailsSourceMaps::VERSION
  gem.authors       = ["Vojtech Hyza"]
  gem.email         = ["vhyza@vhyza.eu"]
  gem.description   = %q{Rails gem for generating sass source maps}
  gem.summary       = %q{Rails gem for generating sass source maps}
  gem.homepage      = "http://github.com/vhyza/sass-rails-source-maps"
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}) { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "rails"
  gem.add_dependency "sprockets", ">= 2.3.0"
  gem.add_dependency "sass",       "~> 3.3"
  gem.add_dependency "sass-rails", "~> 5.0.0.beta1"

  gem.add_development_dependency "bundler", "~> 1.3"
  gem.add_development_dependency "rake"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'garcon/version'

Gem::Specification.new do |spec|
  spec.name          = "garcon"
  spec.version       = Garcon::VERSION
  spec.authors       = ["Rahoul Baruah"]
  spec.email         = ["rahoulb@madeofstone.net"]
  spec.summary       = %q{A simple Service Locator class}
  spec.description   = %q{}
  spec.homepage      = "http://github.com/rahoulb"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.5.0"
  spec.add_development_dependency "mocha", "~> 1.1.0"
end

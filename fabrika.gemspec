# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fabrika/version'

Gem::Specification.new do |spec|
  spec.name          = "fabrika"
  spec.version       = Fabrika::VERSION
  spec.authors       = ["Nikolay Efimov"]
  spec.email         = ["nik.efimov@yahoo.ca"]
  spec.description   = "Mini-Framework for creating step-based processes for Rails"
  spec.summary       = ""
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "rails", "> 3.2"
  spec.add_dependency "activesupport", "> 3.2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec-rails"
end

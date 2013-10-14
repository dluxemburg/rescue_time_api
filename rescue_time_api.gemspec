# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rescue_time_api/version'

Gem::Specification.new do |spec|
  spec.name          = "rescue_time_api"
  spec.version       = RescueTimeApi::VERSION
  spec.authors       = ["Daniel Luxemburg"]
  spec.email         = ["daniel.luxemburg@gmail.com"]
  spec.description   = %q{Ruby wrapper for the RescueTime data API}
  spec.summary       = %q{Ruby wrapper for the RescueTime data API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]


  spec.add_dependency "pry"
  spec.add_dependency "faraday", "~> 0.8.8"
  spec.add_dependency "faraday_middleware"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end

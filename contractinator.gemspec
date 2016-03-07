# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'contractinator/version'

Gem::Specification.new do |spec|
  spec.name          = "contractinator"
  spec.version       = Contractinator::VERSION
  spec.authors       = ["Ehren Murdick", "Tommy Orr", "Nick Mahoney", "Lenny Koepsell"]
  spec.email         = ["pair@pivotal.io"]

  spec.summary       = %q{Contractinator is a tool for contract-driven development!}
  spec.homepage      = "http://github.com/ehrenmurdick/contractinator"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "rspec"
  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
end

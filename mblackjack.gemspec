# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "mblackjack/version"

Gem::Specification.new do |spec|
  spec.name          = "mblackjack"
  spec.version       = Mblackjack::VERSION
  spec.authors       = ["bellvat"]
  spec.email         = ["msirathanarun@gmail.com"]

  spec.summary       = "Blackjack game"
  spec.description   = "Blackjack game"
  spec.homepage      = "https://github.com/bellvat"
  spec.license       = "MIT"

  

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'enygma/version'

Gem::Specification.new do |spec|
  spec.name          = "enygma"
  spec.version       = Enygma::VERSION
  spec.authors       = ["Emmanuel Chigbo"]
  spec.email         = ["emmanuel.chigbo@andela.com"]

  spec.summary       = "A file encryption gem"
  spec.description   = "This gem uses Enigma algorithm to
 encrypt and decrypt a file. It also provides you
 with the ability to crack a file that was encrypted with 'enygma'"
  spec.homepage      = "https://github.com/andela-echigbo/enygma"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
                           .reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = %w(encrypt decrypt crack)
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.10', '>= 1.10.6'
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency "coveralls", "0.8.2"
end

# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name          = "active_model-attribute"
  s.version       = "0.0.2"
  s.author        = "Francesco Rodríguez"
  s.email         = "frodsan@protonmail.com"

  s.summary       = "Declares attribute for Active Model objects"
  s.description   = s.summary
  s.homepage      = "https://github.com/frodsan/active_model-attribute"
  s.license       = "MIT"

  s.files      = Dir["LICENSE", "README.md", "lib/**/*.rb"]
  s.test_files = Dir["test/**/*.rb"]

  s.add_dependency "activemodel", ">= 5.0"

  s.add_development_dependency "bundler", "~> 1.15"
  s.add_development_dependency "minitest", "~> 5.0"
  s.add_development_dependency "rubocop", "~> 0.49"
  s.add_development_dependency "rake", "~> 12.0"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vkontakte_wall_stats/version'

Gem::Specification.new do |spec|
  spec.name          = "vkontakte_wall_stats"
  spec.version       = VkontakteWallStats::VERSION
  spec.authors       = ["AlexanderPavlenko"]
  spec.email         = ["alerticus@gmail.com"]
  spec.summary       = %q{Calculates posts on wall per day statistics}
  spec.description   = %q{}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency 'vkontakte_api'
end

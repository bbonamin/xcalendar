# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'xcalendar/version'

Gem::Specification.new do |spec|
  spec.name          = "xcalendar"
  spec.version       = Xcalendar::VERSION
  spec.authors       = ["Bruno Bonamin"]
  spec.email         = ["bruno@bonamin.org"]
  spec.description   = "Cross Country Soaring calendar builder"
  spec.summary       = "XCalendar takes a list of pilots and builds a calendar of iterations with two pilots per weekend day and holiday"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end

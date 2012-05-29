# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "fluent-logger-rails/version"

Gem::Specification.new do |s|
  s.name        = "fluent-logger-rails"
  s.version     = FluentLoggerRails::VERSION
  s.authors     = ["Waldemar Quevedo"]
  s.email       = ["waldemar.quevedo@gmail.com"]
  s.homepage    = "http://github.com/wallyqs/fluent-logger-rails"
  s.summary     = %q{Gem to swap Rails default logger to use Fluent Ruby plugin }
  s.description = %q{Gem to swap Rails default logger to use Fluent Ruby plugin }

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec"
  s.add_runtime_dependency "fluent-logger"
  s.add_runtime_dependency "rails"
end

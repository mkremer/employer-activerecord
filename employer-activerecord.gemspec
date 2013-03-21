# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'employer-activerecord/version'

Gem::Specification.new do |gem|
  gem.name          = "employer-activerecord"
  gem.version       = Employer::ActiveRecord::VERSION
  gem.authors       = ["Mark Kremer"]
  gem.email         = ["mark@without-brains.net"]
  gem.summary       = %q{ActiveRecord backend for Employer}
  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency "employer", "~> 0.4"
  gem.add_runtime_dependency "activerecord", "~> 3.2"

  gem.add_development_dependency "rspec"
  gem.add_development_dependency "pry"
  gem.add_development_dependency "sqlite3"
end

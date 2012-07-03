# -*- encoding: utf-8 -*-
require File.expand_path('../lib/mongoid-sortable/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Elliott Pogue"]
  gem.email         = ["epogue@gmail.com"]
  # gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{A Mongoid 3.0 module for sorting}
  gem.homepage      = "https://github.com/epogue/mongoid-sortable"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "mongoid-sortable"
  gem.require_paths = ["lib"]
  gem.version       = Mongoid::Sortable::VERSION

  gem.add_dependency 'mongoid', '~> 3.0.0.rc'
  
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'factory_girl', '~> 3.0'
end

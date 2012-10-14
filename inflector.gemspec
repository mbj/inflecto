# -*- encoding: utf-8 -*-

require File.expand_path('../lib/inflector/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name        = 'inflector'
  gem.version     = Inflector::VERSION.dup
  gem.authors     = [] # Will be added when under datamapper org
  gem.email       = %w[] # Same as above
  gem.description = 'Inflector for strings'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/inflector' # Temporal location

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md TODO]

  gem.add_runtime_dependency('backports', '~> 2.6.4')

  gem.add_development_dependency('rake',  '~> 0.9.2')
  gem.add_development_dependency('rspec', '~> 1.3.2')
  gem.add_development_dependency('yard',  '~> 0.8.2')
end

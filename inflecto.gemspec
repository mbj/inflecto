# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.name        = 'inflecto'
  gem.version     = '0.1.0'
  gem.authors     = ['The rails, merb & datamapper team', 'Markus Schirp']
  gem.email       = ['mbj@seonic.net']
  gem.description = 'Inflector for strings'
  gem.summary     = gem.description
  gem.homepage    = 'https://github.com/mbj/inflecto'
  gem.license     = 'MIT'

  gem.require_paths    = %w[lib]
  gem.files            = `git ls-files`.split($/)
  gem.test_files       = `git ls-files spec/{unit,integration}`.split($/)
  gem.extra_rdoc_files = %w[LICENSE README.md TODO]

  gem.required_ruby_version = '>= 1.9.3'
end

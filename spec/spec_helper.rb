# encoding: utf-8

require 'devtools'

Devtools.init_spec_helper

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
  ]

  SimpleCov.start do
    command_name     'spec:unit'
    add_filter       'config'
    add_filter       'spec'
    minimum_coverage 100
  end
end

require 'inflecto'

# require spec support files and shared behavior
Dir[File.expand_path('../{support,shared}/**/*.rb', __FILE__)].each do |file|
  require file
end

# Mutant is already using inflecto. If it mutates inflecto methods then our
# tests start to fail. Instead, we force mutant to use unmutated version of
# inflecto.
module Mutant
  module Inflecto
    ::Inflecto.singleton_methods.each do |name|
      define_singleton_method name, ::Inflecto.method(name).to_proc
    end
  end
end

RSpec.configure do |config|
  # Helps to ensure that inflecto does not modify original input
  def i(object)
    object.freeze
  end
end

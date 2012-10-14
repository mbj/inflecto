require 'spec_helper'

describe Inflector, 'underscore' do
  specify 'allows to create snake_case from CamelCase' do
    Inflector.underscore('CamelCase').should eql('camel_case')
  end
end

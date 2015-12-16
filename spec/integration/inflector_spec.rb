require 'spec_helper'

describe Inflecto, 'underscore' do
  specify 'allows to create snake_case from CamelCase' do
    expect(Inflecto.underscore('CamelCase')).to eql('camel_case')
  end
end

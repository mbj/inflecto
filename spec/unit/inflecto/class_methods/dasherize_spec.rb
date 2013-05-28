require 'spec_helper'

describe Inflecto, '.dasherize' do
  it 'dasherizes data_mapper as data-mapper' do
    Inflecto.dasherize(i('data_mapper')).should == 'data-mapper'
  end
end

require 'spec_helper'

describe Inflecto, '.dasherize' do
  it 'dasherizes data_mapper_rspec as data-mapper-rspec' do
    Inflecto.dasherize(i('data_mapper_rspec')).should == 'data-mapper-rspec'
  end
end

require 'spec_helper'

describe String, '.dasherize' do
  using Inflecto::Refinements

  it 'dasherizes data_mapper_rspec as data-mapper-rspec' do
    i('data_mapper_rspec').dasherize.should == 'data-mapper-rspec'
  end
end

require 'spec_helper'

describe String, '.camelize' do
  using Inflecto::Refinements

  it 'camelizes data_mapper as DataMapper' do
    i('data_mapper').camelize.should == 'DataMapper'
  end

  it 'camelizes merb as Merb' do
    i('merb').camelize.should == 'Merb'
  end

  it 'camelizes data_mapper/resource as DataMapper::Resource' do
    i('data_mapper/resource').camelize.should == 'DataMapper::Resource'
  end

  it 'camelizes data_mapper/associations/one_to_many as DataMapper::Associations::OneToMany' do
    i('data_mapper/associations/one_to_many').camelize.should == 'DataMapper::Associations::OneToMany'
  end
end

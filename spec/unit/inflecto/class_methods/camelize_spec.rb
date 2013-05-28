require 'spec_helper'

describe Inflecto, '.camelize' do
  it 'camelizes data_mapper as DataMapper' do
    Inflecto.camelize(i('data_mapper')).should == 'DataMapper'
  end

  it 'camelizes merb as Merb' do
    Inflecto.camelize(i('merb')).should == 'Merb'
  end

  it 'camelizes data_mapper/resource as DataMapper::Resource' do
    Inflecto.camelize(i('data_mapper/resource')).should == 'DataMapper::Resource'
  end

  it 'camelizes data_mapper/associations/one_to_many as DataMapper::Associations::OneToMany' do
    Inflecto.camelize(i('data_mapper/associations/one_to_many')).should == 'DataMapper::Associations::OneToMany'
  end
end

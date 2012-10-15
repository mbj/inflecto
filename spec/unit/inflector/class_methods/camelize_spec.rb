require 'spec_helper'

describe Inflector do
  describe '.camelize' do
    it 'camelizes data_mapper as DataMapper' do
      Inflector.camelize('data_mapper').should == 'DataMapper'
    end

    it 'camelizes merb as Merb' do
      Inflector.camelize('merb').should == 'Merb'
    end

    it 'camelizes data_mapper/resource as DataMapper::Resource' do
      Inflector.camelize('data_mapper/resource').should == 'DataMapper::Resource'
    end

    it 'camelizes data_mapper/associations/one_to_many as DataMapper::Associations::OneToMany' do
      Inflector.camelize('data_mapper/associations/one_to_many').should == 'DataMapper::Associations::OneToMany'
    end
  end
end

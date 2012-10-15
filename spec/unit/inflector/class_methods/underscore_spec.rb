require 'spec_helper'

describe Inflector do
  describe '.underscore' do
    it 'underscores DataMapper as data_mapper' do
      Inflector.underscore('DataMapper').should == 'data_mapper'
    end

    it 'underscores Merb as merb' do
      Inflector.underscore('Merb').should == 'merb'
    end

    it 'underscores DataMapper::Resource as data_mapper/resource' do
      Inflector.underscore('DataMapper::Resource').should == 'data_mapper/resource'
    end

    it 'underscores Merb::BootLoader::Rackup as merb/boot_loader/rackup' do
      Inflector.underscore('Merb::BootLoader::Rackup').should == 'merb/boot_loader/rackup'
    end
  end
end

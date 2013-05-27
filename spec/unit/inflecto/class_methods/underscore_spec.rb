require 'spec_helper'

describe Inflecto, '.underscore' do
  it 'underscores DataMapper as data_mapper' do
    Inflecto.underscore(i('DataMapper')).should == 'data_mapper'
  end

  it 'underscores Merb as merb' do
    Inflecto.underscore(i('Merb')).should == 'merb'
  end

  it 'underscores DataMapper::Resource as data_mapper/resource' do
    Inflecto.underscore(i('DataMapper::Resource')).should == 'data_mapper/resource'
  end

  it 'underscores Merb::BootLoader::Rackup as merb/boot_loader/rackup' do
    Inflecto.underscore(i('Merb::BootLoader::Rackup')).should == 'merb/boot_loader/rackup'
  end
end

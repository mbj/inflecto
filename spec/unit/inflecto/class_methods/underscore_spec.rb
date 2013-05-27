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

  it 'underscores data-mapper as data_mapper' do
    Inflecto.underscore(i('data-mapper')).should == 'data_mapper'
  end

  it 'underscores CLI as cli' do
    Inflecto.underscore(i('CLI')).should == 'cli'
  end

  it 'underscores castleKing as castle_king' do
    Inflecto.underscore(i('castleKing')).should == 'castle_king'
  end

  it 'underscores CLIRunner as cli_runner' do
    Inflecto.underscore(i('CLIRunner')).should == 'cli_runner'
  end
end

require 'spec_helper'

describe String, '.underscore' do
  using Inflecto::Refinements

  it 'underscores DataMapper as data_mapper' do
    i('DataMapper').underscore.should == 'data_mapper'
  end

  it 'underscores Merb as merb' do
    i('Merb').underscore.should == 'merb'
  end

  it 'underscores DataMapper::Resource as data_mapper/resource' do
    i('DataMapper::Resource').underscore.should == 'data_mapper/resource'
  end

  it 'underscores Merb::BootLoader::Rackup as merb/boot_loader/rackup' do
    i('Merb::BootLoader::Rackup').underscore.should == 'merb/boot_loader/rackup'
  end

  it 'underscores data-mapper as data_mapper' do
    i('data-mapper').underscore.should == 'data_mapper'
  end

  it 'underscores CLI as cli' do
    i('CLI').underscore.should == 'cli'
  end

  it 'underscores castleKing as castle_king' do
    i('castleKing').underscore.should == 'castle_king'
  end

  it 'underscores CLIRunner as cli_runner' do
    i('CLIRunner').underscore.should == 'cli_runner'
  end
end

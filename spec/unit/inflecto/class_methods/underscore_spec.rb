require 'spec_helper'

describe Inflecto, '.underscore' do
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

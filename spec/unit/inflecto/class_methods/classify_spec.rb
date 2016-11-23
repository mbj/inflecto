require 'spec_helper'

describe Inflecto, '.classify' do
  it 'classifies data_mapper as DataMapper' do
    Inflecto.classify('data_mapper').should == 'DataMapper'
  end

  it 'classifies enlarged_testes as EnlargedTestis' do
    Inflecto.classify('enlarged_testes').should == 'EnlargedTestis'
  end

  it 'singularizes string first: classifies data_mappers as egg_and_hams as EggAndHam' do
    Inflecto.classify('egg_and_hams').should == 'EggAndHam'
  end

  it 'coerces its input to a string' do
    Inflecto.classify(:weird_new_trick).should == 'WeirdNewTrick'
  end

  it 'strips out leading schema names' do
    Inflecto.classify('my_schema.my_table').should == 'MyTable'
  end
end

require 'spec_helper'

describe Inflector, '.classify' do
  it 'classifies data_mapper as DataMapper' do
    Inflector.classify('data_mapper').should == 'DataMapper'
  end

  it 'classifies enlarged_testes as EnlargedTestis' do
    Inflector.classify('enlarged_testes').should == 'EnlargedTestis'
  end

  it 'singularizes string first: classifies data_mappers as egg_and_hams as EggAndHam' do
    Inflector.classify('egg_and_hams').should == 'EggAndHam'
  end
end

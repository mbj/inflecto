require 'spec_helper'

describe Inflecto, '.classify' do
  it 'classifies data_mapper as DataMapper' do
    Inflecto.classify(i('data_mapper')).should == 'DataMapper'
  end

  it 'classifies data.mapper as Mapper' do
    Inflecto.classify(i('data.mapper')).should == 'Mapper'
  end

  it 'classifies enlarged_testes as EnlargedTestis' do
    Inflecto.classify(i('enlarged_testes')).should == 'EnlargedTestis'
  end

  it 'singularizes string first: classifies data_mappers as egg_and_hams as EggAndHam' do
    Inflecto.classify(i('egg_and_hams')).should == 'EggAndHam'
  end
end

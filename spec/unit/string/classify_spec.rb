require 'spec_helper'

describe String, '.classify' do
  using Inflecto::Refinements

  it 'classifies data_mapper as DataMapper' do
    i('data_mapper').classify.should == 'DataMapper'
  end

  it 'classifies data.mapper as Mapper' do
    i('data.mapper').classify.should == 'Mapper'
  end

  it 'classifies enlarged_testes as EnlargedTestis' do
    i('enlarged_testes').classify.should == 'EnlargedTestis'
  end

  it 'singularizes string first: classifies data_mappers as egg_and_hams as EggAndHam' do
    i('egg_and_hams').classify.should == 'EggAndHam'
  end
end

require 'spec_helper'

describe Inflector do
  describe '.classify' do
    it 'classifies data_mapper as DataMapper' do
      Inflector.classify('data_mapper').should == 'DataMapper'
    end

    pending 'classifies enlarged_testes as EnlargedTestis' do
      Inflector.classify('enlarged_testes').should == 'EnlargedTestis'
    end

    pending 'singularizes string first: classifies data_mappers as egg_and_hams as EggAndHam' do
      Inflector.classify('egg_and_hams').should == 'EggAndHam'
    end
  end
end

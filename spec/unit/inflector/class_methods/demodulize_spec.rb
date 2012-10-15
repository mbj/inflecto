require 'spec_helper'

describe Inflector do
  describe '.demodulize' do
    it 'demodulizes module name: DataMapper::Inflector => Inflector' do
      Inflector.demodulize('DataMapper::Inflector').should == 'Inflector'
    end

    it 'demodulizes module name: A::B::C::D::E => E' do
      Inflector.demodulize('A::B::C::D::E').should == 'E'
    end
  end
end

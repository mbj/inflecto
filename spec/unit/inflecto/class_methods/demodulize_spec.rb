require 'spec_helper'

describe Inflecto do
  describe '.demodulize' do
    it 'demodulizes module name: DataMapper::Inflecto => Inflecto' do
      Inflecto.demodulize('DataMapper::Inflecto').should == 'Inflecto'
    end

    it 'demodulizes module name: A::B::C::D::E => E' do
      Inflecto.demodulize('A::B::C::D::E').should == 'E'
    end

    it 'coerces its input to a string' do
      Inflecto.demodulize('A::B::C::D::X'.to_sym).should == 'X'
    end
  end
end

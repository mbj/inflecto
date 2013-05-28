require 'spec_helper'

describe Inflecto, '.demodulize' do
  it 'demodulizes module name: DataMapper::Inflecto => Inflecto' do
    Inflecto.demodulize(i('DataMapper::Inflecto')).should == 'Inflecto'
  end

  it 'demodulizes module name: A::B::C::D::E => E' do
    Inflecto.demodulize(i('A::B::C::D::E')).should == 'E'
  end
end

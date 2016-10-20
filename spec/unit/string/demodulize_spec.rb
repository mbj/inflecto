require 'spec_helper'

describe String, '.demodulize' do
  using Inflecto::Refinements

  it 'demodulizes module name: DataMapper::Inflecto => Inflecto' do
    i('DataMapper::Inflecto').demodulize.should == 'Inflecto'
  end

  it 'demodulizes module name: A::B::C::D::E => E' do
    i('A::B::C::D::E').demodulize.should == 'E'
  end
end

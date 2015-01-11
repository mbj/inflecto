require 'spec_helper'

describe Inflecto, '.uncountable?' do
  it 'truthy when empty string' do
    Inflecto.uncountable?('').should == true
  end

  it 'truthy when word is present in list' do
    Inflecto.uncountable?('grass').should be(true)
  end

  it 'falsy when word is not present in list' do
    Inflecto.uncountable?('user').should be(false)
  end

  it 'truthy when word is present in list but in different case' do
    Inflecto.uncountable?('FiSH').should be(true)
  end
end

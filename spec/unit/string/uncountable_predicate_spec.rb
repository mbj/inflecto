require 'spec_helper'

describe String, '.uncountable?' do
  using Inflecto::Refinements

  it 'truthy when empty string' do
    ''.uncountable?.should be(true)
  end

  it 'truthy when word is present in list' do
    'grass'.uncountable?.should be(true)
  end

  it 'falsy when word is not present in list' do
    'user'.uncountable?.should be(false)
  end

  it 'truthy when word is present in list but in different case' do
    'FiSH'.uncountable?.should be(true)
  end
end

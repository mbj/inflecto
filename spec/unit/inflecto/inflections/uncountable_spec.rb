require 'spec_helper'

describe Inflecto::Inflections, '#uncountable' do
  let(:object) { described_class.new }

  context 'when word given' do
    subject { object.uncountable('water') }
    its(:uncountables) { should contain_exactly('water') }
  end

  context 'when array of words given' do
    subject { object.uncountable(['water', 'sugar']) }
    its(:uncountables) { should contain_exactly('water', 'sugar') }
  end

  context 'when multiple words given' do
    subject { object.uncountable('water', 'sugar') }
    its(:uncountables) { should contain_exactly('water', 'sugar') }
  end
end

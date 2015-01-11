require 'spec_helper'

describe Inflecto::Inflections, '#plural' do
  subject { object.plural(rule, replacement) }

  let(:object)      { described_class.new }
  let(:rule)        { double(:rule) }
  let(:replacement) { double(:replacement) }

  it { should be(object) }

  its(:plurals) { should eq([[rule, replacement]]) }

  it 'adds rule as a first item' do
    subject
    object.plural(double, double)

    plurals = object.plurals
    plurals.size.should be(2)
    plurals.last.should eq([rule, replacement])
  end

  context 'when rule is in the uncountables' do
    before { object.uncountable(rule) }

    it 'removes it from uncountables' do
      subject.uncountables.should eql(Set[])
    end
  end

  context 'when replacement is in the uncountables' do
    before { object.uncountable(replacement) }

    it 'removes it from uncountables' do
      subject.uncountables.should eql(Set[])
    end
  end
end

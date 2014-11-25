require 'spec_helper'

describe Inflecto::Inflections, '#human' do
  subject { object.human(rule, replacement) }

  let(:object)      { described_class.new }
  let(:rule)        { double(:rule) }
  let(:replacement) { double(:replacement) }

  it { should be(object) }

  its(:humans) { should eq([[rule, replacement]]) }

  it 'adds rule as a first item' do
    subject
    object.human(double, double)

    humans = object.humans
    humans.size.should be(2)
    humans.last.should eq([rule, replacement])
  end
end

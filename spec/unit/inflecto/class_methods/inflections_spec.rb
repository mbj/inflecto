require 'spec_helper'

describe Inflecto, '.inflections' do
  context 'when block given' do
    it 'yields inflections instance' do
      yielded = nil

      described_class.inflections do |inflect|
        yielded = inflect
      end

      yielded.should eq(Inflecto::Inflections.instance)
    end
  end

  context 'when without block' do
    subject { described_class.inflections }

    it { should be(Inflecto::Inflections.instance) }
  end
end

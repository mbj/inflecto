require 'spec_helper'

describe Inflecto::Inflections, '#irregular' do
  subject { object.irregular(singular, plural) }

  let(:object)   { described_class.new }
  let(:singular) { 'person' }
  let(:plural)   { 'people' }

  it { should be(object) }

  its(:plurals)   { should include([/(p)erson\z/i, "\\1eople"]) }
  its(:singulars) { should include([/(p)eople\z/i, "\\1erson"]) }

  context 'when singular form is in uncountables' do
    before { object.uncountable('person') }

    it 'removes it from uncountables' do
      subject.uncountables.should_not include('person')
    end
  end

  context 'when plural form is in uncountables' do
    before { object.uncountable('people') }

    it 'removes it from uncountables' do
      subject.uncountables.should_not include('people')
    end
  end
end

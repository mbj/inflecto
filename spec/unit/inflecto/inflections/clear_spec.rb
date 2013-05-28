require 'spec_helper'

describe Inflecto::Inflections, '#clear' do
  subject { object.clear }

  let(:object) { described_class.new }

  before do
    object.uncountable('apple')
    object.plural('people', 'person')
    object.singular('apple', 'apples')
    object.human('person_name', 'Name')
  end

  it { should be(object) }

  its(:plurals)      { should be_empty }
  its(:singulars)    { should be_empty }
  its(:uncountables) { should be_empty }
  its(:humans)       { should be_empty }
end

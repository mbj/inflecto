require 'spec_helper'

describe Inflecto::Inflections, '.instance' do
  subject { described_class.instance }

  it { should be_instance_of(described_class) }

  it 'returns always same instance' do
    subject.should equal(described_class.instance)
  end
end

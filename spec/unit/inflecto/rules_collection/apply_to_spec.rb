require 'spec_helper'

describe Inflecto::RulesCollection, '#apply_to' do
  subject { described_class.new(rules).apply_to(input) }

  let(:rules) do
    [
      ['question', 'questions'],
      ['quest', 'quests']
    ]
  end
  let(:input) { 'question' }

  it { should eq('questions') }

  it { should_not equal(input) }
end

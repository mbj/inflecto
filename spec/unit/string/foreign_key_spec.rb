require 'spec_helper'

describe String, '.foreign_key' do
  using Inflecto::Refinements

  it 'adds _id to downcased string: Message => message_id' do
    i('Message').foreign_key.should == 'message_id'
  end

  it 'demodulizes string first: Admin::Post => post_id' do
    i('Admin::Post').foreign_key.should == 'post_id'
  end
end

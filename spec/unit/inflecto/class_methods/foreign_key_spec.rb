require 'spec_helper'

describe Inflecto, '.foreign_key' do
  it 'adds _id to downcased string: Message => message_id' do
    Inflecto.foreign_key(i('Message')).should == 'message_id'
  end

  it 'demodulizes string first: Admin::Post => post_id' do
    Inflecto.foreign_key(i('Admin::Post')).should == 'post_id'
  end
end

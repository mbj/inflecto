require 'spec_helper'

describe Inflector do
  describe '.foreign_key' do
    it 'adds _id to downcased string: Message => message_id' do
      Inflector.foreign_key('Message').should == 'message_id'
    end

    it 'demodulizes string first: Admin::Post => post_id' do
      Inflector.foreign_key('Admin::Post').should == 'post_id'
    end
  end
end

require 'spec_helper'

describe Inflecto do
  describe '.humanize' do
    it 'replaces _ with space: humanizes employee_salary as Employee salary' do
      Inflecto.humanize('employee_salary').should == 'Employee salary'
    end

    it 'strips _id endings: humanizes author_id as Author' do
      Inflecto.humanize('author_id').should == 'Author'
    end

    it 'coerces its input to a string' do
      Inflecto.humanize(:commenter_id).should == 'Commenter'
    end

    it 'looks up inflections in the humans namespace' do
      Inflecto::Inflections.instance.stub(:humans).and_return(
        [['awful', 'tuna'], ['meat', 'bread'], ['sandwich', 'italian']]
      )
      input = 'sandwich_meat'
      Inflecto.humanize(input).should == 'Sandwich bread'
    end

    it 'dupes the input' do
      Inflecto::Inflections.instance.stub(:humans).and_return([['meat', 'bread']])
      input = 'sandwich_meat'
      Inflecto.humanize(input)
      input.should == 'sandwich_meat'
    end
  end
end

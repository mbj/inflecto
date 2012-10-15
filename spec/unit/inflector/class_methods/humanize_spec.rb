require 'spec_helper'

describe Inflector do
  describe '.humanize' do
    it 'replaces _ with space: humanizes employee_salary as Employee salary' do
      Inflector.humanize('employee_salary').should == 'Employee salary'
    end

    it 'strips _id endings: humanizes author_id as Author' do
      Inflector.humanize('author_id').should == 'Author'
    end
  end
end


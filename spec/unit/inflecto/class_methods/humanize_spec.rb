require 'spec_helper'

describe Inflecto, '.humanize' do
  it 'replaces _ with space: humanizes employee_salary as Employee salary' do
    Inflecto.humanize(i('employee_salary')).should == 'Employee salary'
  end

  it 'strips _id endings: humanizes author_id as Author' do
    Inflecto.humanize(i('author_id')).should == 'Author'
  end

  it 'uses user added rules when possible' do
    Inflecto.inflections do |inflect|
      inflect.human('Question', 'Fancy question')
      inflect.human('questionary', 'Questionnaire')
    end

    Inflecto.humanize(i('questionary')).should == 'Questionnaire'
  end
end

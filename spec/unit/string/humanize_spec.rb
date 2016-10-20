require 'spec_helper'

describe String, '.humanize' do
  using Inflecto::Refinements

  it 'replaces _ with space: humanizes employee_salary as Employee salary' do
    i('employee_salary').humanize.should == 'Employee salary'
  end

  it 'strips _id endings: humanizes author_id as Author' do
    i('author_id').humanize.should == 'Author'
  end

  it 'uses user added rules when possible' do
    Inflecto.inflections do |inflect|
      inflect.human('Question', 'Fancy question')
      inflect.human('questionary', 'Questionnaire')
    end

    i('questionary').humanize.should == 'Questionnaire'
  end
end

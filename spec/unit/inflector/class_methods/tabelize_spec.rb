require 'spec_helper'

describe Inflector, '.tableize' do
  it 'pluralizes last word in snake_case strings: fancy_category => fancy_categories' do
    Inflector.tableize('fancy_category').should == 'fancy_categories'
  end

  it 'underscores CamelCase strings before pluralization: enlarged_testis => enlarged_testes' do
    Inflector.tableize('enlarged_testis').should == 'enlarged_testes'
  end

  it 'underscores CamelCase strings before pluralization: FancyCategory => fancy_categories' do
    Inflector.tableize('FancyCategory').should == 'fancy_categories'
  end

  it 'underscores CamelCase strings before pluralization: EnlargedTestis => enlarged_testes' do
    Inflector.tableize('EnlargedTestis').should == 'enlarged_testes'
  end

  it 'replaces :: with underscores: Fancy::Category => fancy_categories' do
    Inflector.tableize('Fancy::Category').should == 'fancy_categories'
  end

  it 'underscores CamelCase strings before pluralization: Enlarged::Testis => enlarged_testes' do
    Inflector.tableize('Enlarged::Testis').should == 'enlarged_testes'
  end
end

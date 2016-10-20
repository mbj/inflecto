require 'spec_helper'

describe String, '.tableize' do
  using Inflecto::Refinements

  it 'pluralizes last word in snake_case strings: fancy_category => fancy_categories' do
    i('fancy_category').tableize.should == 'fancy_categories'
  end

  it 'underscores CamelCase strings before pluralization: enlarged_testis => enlarged_testes' do
    i('enlarged_testis').tableize.should == 'enlarged_testes'
  end

  it 'underscores CamelCase strings before pluralization: FancyCategory => fancy_categories' do
    i('FancyCategory').tableize.should == 'fancy_categories'
  end

  it 'underscores CamelCase strings before pluralization: EnlargedTestis => enlarged_testes' do
    i('EnlargedTestis').tableize.should == 'enlarged_testes'
  end

  it 'replaces :: with underscores: My::Fancy::Category => my_fancy_categories' do
    i('My::Fancy::Category').tableize.should == 'my_fancy_categories'
  end

  it 'underscores CamelCase strings before pluralization: Enlarged::Testis => enlarged_testes' do
    i('Enlarged::Testis').tableize.should == 'enlarged_testes'
  end
end

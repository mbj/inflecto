require 'spec_helper'

describe String, '.constantize' do
  using Inflecto::Refinements

  it 'constantizes Module' do
    i('Module').constantize.should == Module
  end

  it 'constantizes ::Module' do
    i('::Module').constantize.should == Module
  end

  it 'constantizes nested constant Inflecto::Inflections' do
    i('Inflecto::Inflections').constantize.should == Inflecto::Inflections
  end

  it 'does not search ancestors' do
    module Foo
      class Bar
        VAL = 10
      end

      class Baz < Bar; end
    end

    expect {
      i('Foo::Baz::VAL').constantize
    }.to raise_error(NameError)
  end

  it 'searches in const_missing' do
    module Foo
      class Bar
        def self.const_missing(name)
          name.to_s == 'Const' ? Baz : super
        end
      end

      class Baz < Bar; end

      def self.const_missing(name)
        name.to_s == 'Autoloaded' ? Bar : super
      end
    end

    i('Foo::Autoloaded::Const').constantize.should == Foo::Baz
    i('Foo::Bar::Const').constantize.should == Foo::Baz
  end

  it 'raises exception when empty string given' do
    expect {
      i('').constantize
    }.to raise_error(NameError)
  end

  it 'raises exception when constant not found' do
    expect {
      i('Qwerty').constantize
    }.to raise_error(NameError)
  end
end

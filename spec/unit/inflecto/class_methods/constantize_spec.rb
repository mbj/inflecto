require 'spec_helper'

describe Inflecto, '.constantize' do
  it 'constantizes Module' do
    Inflecto.constantize(i('Module')).should == Module
  end

  it 'constantizes ::Module' do
    Inflecto.constantize(i('::Module')).should == Module
  end

  it 'constantizes nested constant Inflecto::Inflections' do
    Inflecto.constantize(i('Inflecto::Inflections')).should == Inflecto::Inflections
  end

  it 'does not search ancestors' do
    module Foo
      class Bar
        VAL = 10
      end

      class Baz < Bar; end
    end

    expect {
      Inflecto.constantize(i('Foo::Baz::VAL'))
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

    Inflecto.constantize(i('Foo::Autoloaded::Const')).should == Foo::Baz
    Inflecto.constantize(i('Foo::Bar::Const')).should == Foo::Baz
  end

  it 'raises exception when empty string given' do
    expect {
      Inflecto.constantize(i(''))
    }.to raise_error(NameError)
  end

  it 'raises exception when constant not found' do
    expect {
      Inflecto.constantize(i('Qwerty'))
    }.to raise_error(NameError)
  end
end

require 'spec_helper'

describe Raudi::ActionProcessor do

  context 'processing keys' do

    let(:action_text) { "Some dummy test" }

    it 'string/symbol be same' do
      subject['foo'] = action_text
      subject[:foo].should == action_text
    end

    it 'case unsensative' do
      subject[:FOOBar] = action_text
      subject[:foobar].should == action_text
    end

    it 'allow 2 key format' do
      subject[:foo, 2] = action_text
      subject[:foo2].should == action_text
    end

    context 'using alias key' do

      it 'for interrupt action' do
        subject[:interrupt] = action_text
        subject[:int].should == action_text
      end

    end

  end

end

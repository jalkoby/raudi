require 'spec_helper'

describe Raudi::ActionProcessor do

  it 'should key unsensative' do
    action_text = "Some dummy test"
    subject['foo'] = action_text
    subject[:foo].should == action_text
  end

end

require 'spec_helper'

describe Raudi::AVR::Timer do

  let(:timer) { klass.new('timer_0', 'length' => 8) }
  
  specify{ timer.number.should == 0 }

  specify{ timer.range.should include(23)}
  specify{ timer.range.should_not include(256)}

  it 'should change params when mode changed' do
    timer.mode = :foo
    timer.mode_params.should == {}
    timer.mode_params[:a] = 34
    timer.mode = :foo
    timer.mode_params[:a].should == 34
    timer.mode = :bar
    timer.mode_params.should == {}
  end

end

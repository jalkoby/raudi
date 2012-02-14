require 'spec_helper'

describe Raudi::AVR::Controller do

  it 'should have 3 timers' do
    controller.timers.should have(3).items
    controller.timers[0].length.should == 8
    controller.timers[1].length.should == 16
    controller.timers[2].length.should == 8
  end

end


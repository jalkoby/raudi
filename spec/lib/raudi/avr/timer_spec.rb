require 'spec_helper'

describe Raudi::AVR::Timer do

  let(:timer) { klass.new('timer_0', 'length' => 8) }
  
  specify{ timer.number.should == 0 }

end

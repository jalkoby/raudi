require 'spec_helper'

describe 'Generation main structure' do
  
  it 'should warp setup block' do
    source.should include("int delay_time = 500;")
  end

  it 'should warp main block' do
    source.should include("_delay_ms(delay_time);")
    source.should include("toggle_pin(PIN3);")
  end

  it 'should allow interrupt' do
    controller.with_interrupt = true
    source.should include('sei();')
  end

end
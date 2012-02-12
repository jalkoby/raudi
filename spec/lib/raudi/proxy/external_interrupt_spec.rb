require 'spec_helper'

describe 'Proxy for external interrupt' do
  
  it 'external interrupt' do
    config.external_interrupt :d2 => :falling, :d3 => :rising
    controller.with_interrupt.should be_true
    pin = get_pin(:d, 3)
    pin.should be_int
    pin.state_params.should == :rising
    controller.headers.should include('avr/interrupt')
  end

  it 'pin change interrupt' do
    config.pc_interrupt :b3, :d4
    controller.with_interrupt.should be_true
    pin = get_pin(:b, 3)
    pin.should be_pcint
    controller.headers.should include('avr/interrupt')
  end

end
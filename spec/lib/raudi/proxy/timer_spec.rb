require 'spec_helper'

describe 'Proxy for timer/counter' do

  context 'define timers' do

    it 'basic config' do
      config.activate_timer 0
      timer = controller.timers[0]
      timer.active.should be_true
      timer.prescale.should == 1
    end

    it 'set prescale' do
      config.activate_timer 1, :prescale => 8
      timer = controller.timers[1]
      timer.active.should be_true
      timer.prescale.should == 2
    end

    it 'set invalid prescale' do
      config.activate_timer 2, :prescale => 5
      timer = controller.timers[2]
      timer.active.should be_true
      timer.prescale.should == 1
    end

    it 'set timer with interrupt' do
      config.activate_timer 1, :overflow => true
      controller.interrupt.should be_true
      timer = controller.timers[1]
      timer.overflow.should be_true
      controller.headers.should include('avr/interrupt')
    end

  end

  context 'define counter' do

    it 'set timer 0 to counter' do
      config.activate_counter 0
      controller.timers[0].counter.should be
      controller.timers[0].prescale.should == 6
      pin = get_pin(:d, 4)
      pin.should be_counter
    end

  end

end

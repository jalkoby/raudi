require 'spec_helper'

describe 'Proxy for timer/counter' do

  context 'define timers' do

    it 'normal config' do
      config.timer :d5, :tick => 200
      pin = get_pin(:d, 5)
      pin.should be_timer
      pin.state_params[:tick].should == 200
    end

    it 'set period in second' do
      config.timer :d4, :tick => '1.4s'
      pin = get_pin(:d, 4)
      pin.should be_timer
      pin.state_params[:tick].should == 1400
    end

    it 'set period in minutes' do
      config.timer :d4, :tick => '0.23m'
      pin = get_pin(:d, 4)
      pin.state_params[:tick].should == 13800
    end

    it 'set timer with interrupt' do
      config.timer :d5, :tick => 150, :interrupt => true
      controller.with_interrupt.should be_true
      controller.headers.should include('avr/interrupt')
    end

  end

end
require 'spec_helper'

describe Raudi::AVR::Pin do

  let(:port){ Raudi::AVR::Port.new("C", {'pins' => []}) }

  context 'generate c presentation' do

    context 'as gpio' do

      let(:pin) { Raudi::AVR::Pin.new(port, 3, []) }

      it 'input' do
        pin.to_c.should == "PINC3"
        pin.should be_input
      end

      it 'output' do
        pin.output!
        pin.to_c.should == 'PINC3'
        pin.should be_output
      end

      it 'pullup' do
        pin.pullup!
        pin.to_c.should == 'PINC3'
        pin.should be_pullup
      end

    end

    it 'as eint' do
      pin = klass.new(port, 2, ["int_0"])
      pin.int!
      pin.to_c.should == "INT0"
      pin.should be_int
    end

  end

  context 'state checks' do

    let(:pin) { Raudi::AVR::Pin.new(port, 3, ['timer_1', 'eint_0', 'pcint_4']) }

    it 'should be input by default' do
      pin.should be_input
    end

    it 'can be pullup by default' do
      pin.can_be_pullup?.should be_true
      pin.pullup!
      pin.should be_pullup
    end

    it 'can be output by default' do
      pin.can_be_output?.should be_true
      pin.output!
      pin.should be_output
    end

    it 'can be timer' do
      pin.can_be_timer?.should be_true
      pin.can_be_timer?(2).should be_false
      pin.timer!
      pin.should be_timer
    end

  end

end

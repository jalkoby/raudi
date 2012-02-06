require 'spec_helper'

describe Raudi::AVR::ControllerProxy do

  let(:controller) { Raudi::AVR::Controller.new :atmega_328 }
  let(:config){ Raudi::AVR::ControllerProxy.new(controller) }

  context 'it define gpio' do

    it 'define output pins' do
      config.output :d0, :d3
      config.output :b0, :b2, :b3
      controller.ports(:d).output_pins.should have(2).items
      controller.ports(:b).output_pins[0].number.should == 0
    end

    it 'define pullup pins' do
      config.pullup :a3, :a5, :b5
      controller.ports(:a).should have(2).pullup_pins
      controller.ports(:b).should have(1).pullup_pins
    end

  end

  context 'define headers' do

    it 'normal case' do
      config.headers 'util/twi'
      config.headers 'avr/io'
      controller.headers.should have(2).items
    end

    it 'use symbols' do
      config.headers :io, :boot
      controller.headers.should have(2).items
      controller.headers.should include("avr/io")
    end

    it 'remove duplication' do
      config.headers :io, 'avr/io', "avr/io"
      controller.headers.should have(1).item
      controller.headers.should include('avr/io')
    end

    it 'remove unknow header' do
      config.headers :wazza, 'avr/foo', 'sample'
      controller.headers.should be_empty
    end 

  end

  context 'define interrupts' do

    it 'with eint' do
      config.eint :b3
      controller.with_interrupt.should be_true
      controller.ports(:b).pins(3).state.should == 'eint_0'
      controller.headers.should include('avr/interrupt')
    end

  end

end

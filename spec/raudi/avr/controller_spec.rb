require 'spec_helper'

describe Raudi::AVR::Controller do

  # context 'defining:' do

  #   context 'libs section:' do
      
  #     it 'specifing libs' do
  #       controller = klass.new :atmega_328 do |controller|
  #         controller.headers :io, 'foo_module', 'util/twi'
  #         controller.headers :wazza, 'math', 'avr/io'
  #       end
  #       controller.headers.should have(3).items
  #       controller.headers.should include('avr/io')
  #       controller.to_c.should include("#include <avr/io.h>\n#include <util/twi.h>\n#include <math.h>\n")
  #     end

  #   end

  #   context 'pin section' do

  #     it 'set output pins' do
  #       controller = klass.new :atmega_328 do |config|
  #         config.output :d0, :d3
  #         config.output :b0, :b2, :b3
  #       end
  #       controller.ports(:d).output_pins.should have(2).items
  #       controller.ports(:b).output_pins[0].number.should == 0
  #       controller.to_c.should include("DDRB |= 1 << 0 || 1 << 2 || 1 << 3;")
  #       controller.to_c.should include("DDRD |= 1 << 0 || 1 << 3;")
  #     end

  #     it 'set pin to pullup' do
  #       controller = klass.new :atmega_328 do |config|
  #         config.pullup :a3, :a5, :b5
  #       end
  #       controller.ports(:a).should have(2).pullup_pins
  #       controller.ports(:b).should have(1).pullup_pins
  #       controller.to_c.should include("PORTB |= 1 << 5;")
  #       controller.to_c.should include("PORTA |= 1 << 3 || 1 << 5;")
  #     end

  #   end

  #   context 'with interrupt' do

  #     it 'eint interrupt' do
  #       controller = klass.new  :atmega_328 do |config|
  #         config.eint :b3
  #       end
  #       controller.with_interrupt.should be_true
  #       controller.ports(:b).pins(3).state.should == 'eint'
  #       controller.headers.should include('avr/interrupt')
  #       controller.to_c.should include("sei();")
  #     end

  #   end

  # end

end


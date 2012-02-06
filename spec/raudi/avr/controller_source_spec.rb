require 'spec_helper'

describe Raudi::AVR::ControllerSource do
  
  let(:controller) { Raudi::AVR::Controller.new :atmega_328 }
  let(:config){ Raudi::AVR::ControllerProxy.new(controller) }
  let(:source){ controller.to_c }

  context 'generate pgio config' do
    
    it 'output pins' do
      config.output :b2, :a3, :b5, :d2
      source.should include("DDRA |= 1 << 3;")
      source.should include("DDRB |= 1 << 2 || 1 << 5;")
      source.should include("DDRD |= 1 << 2;")
    end

    it 'pullup pins' do
      config.pullup :a3, :b3, :b2, :b4
      source.should include("PORTA |= 1 << 3;")
      source.should include("PORTB |= 1 << 2 || 1 << 3 || 1 << 4;")
    end

  end

  context 'code with interrupt' do

    it 'eint' do
      config.eint :b3
      source.should include('sei();')
      source.should include('ISR(INT0_vect)')
      # source.should include('')
    end

  end

end

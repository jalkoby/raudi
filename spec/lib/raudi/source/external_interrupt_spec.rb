require 'spec_helper'

describe 'Generate external interrupt code' do
  
  context 'external interrupt' do

    it 'rising' do
      config.external_interrupt :d2 => :rising
      source.should include('sei();')
      source.should include('ISR(INT0_vect)')
      source.should include('EIMSK |= 1 << INT0;')
      source.should include('EICRA |= 1 << ISC00 | 1 << ISC01;')
      source.should include('int k;')
      source.should include('for(k = 0; k < 4; k++);')
    end

    it 'falling' do
      config.external_interrupt :d3 => :falling
      source.should include('EIMSK |= 1 << INT1;')
      source.should include('EICRA |= 1 << ISC11;')
    end

    it 'define two interrupts' do
      config.external_interrupt :d2 => :both, :d3 => :falling
      source.should include('ISR(INT0_vect)')
      source.should include('ISR(INT1_vect)')
      source.should include('EIMSK |= 1 << INT0 | 1 << INT1;')
      source.should include('EICRA |= 1 << ISC00 | 1 << ISC11;')
    end

  end

  context 'pin change interrupt' do

    it 'for pins b1 and b5' do
      config.pc_interrupt :b1, :b5
      source.should include("sei();")
      source.should include('PCMSK0 |= 1 << PCINT1 | 1 << PCINT5;')
      source.should include('ISR(PCINT0_vect)')
      source.should include('PCICR |= 1 << PCIE0;')
    end

    it 'pin c3 and d5' do
      config.pc_interrupt :c3, :d5
      source.should include('PCMSK1 |= 1 << PCINT11;')
      source.should include('PCMSK2 |= 1 << PCINT21;')
      source.should include('ISR(PCINT1_vect)')
      source.should include('ISR(PCINT2_vect)')
      source.should include('PCICR |= 1 << PCIE1 | 1 << PCIE2;')
    end

  end

end

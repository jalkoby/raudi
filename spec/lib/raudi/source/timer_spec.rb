require 'spec_helper'

describe 'Generate timer/counter code' do

  context 'basic setup timer' do

    it 'allow timer 0' do
      config.activate_timer 0
      source.should include('TCCR0B |= 1 << CS00;')
    end

    it 'timer 1 prescale to 64' do
      config.activate_timer 1, :prescale => 64
      source.should include('TCCR1B |= 1 << CS10 | 1 << CS11;')
    end

  end

  context 'with interrupts' do

    it 'basic example' do
      config.activate_timer 0, :interrupt => true
      source.should include('ISR(TIMER0_OVF_vect)')
      source.should include('TIMSK0 |= 1 << TOIE0;')
    end

    it 'ctc interrupt' do
      config.activate_timer 1, :a => 12745, :interrupt => true
      source.should include('ISR(TIMER1_COMPA_vect)')
      source.should include('TCCR1B |= 1 << CS10 | 1 << WGM12;')
    end

  end

  context 'basic setup counter' do

    it 'allow counter 0' do
      config.activate_counter 0
      source.should include('TCCR0B |= 1 << CS01 | 1 << CS02;')
    end

  end

end

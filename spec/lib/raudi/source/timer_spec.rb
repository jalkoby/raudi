require 'spec_helper'

describe 'Generate timer/counter code' do

  context 'basic setup timer' do

    before :each do
      config.activate_timer 0
    end

    it 'allow timer 1' do
      source.should include('TCCR0B |= 1 << CS01;')
    end

  end

  context 'basic setup counter' do

    before :each do
      config.activate_counter 1
    end

  end

end

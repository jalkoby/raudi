require 'spec_helper'

describe 'Generate timer/counter code' do

  context 'basic setup timer' do
    
    before do
      config.timer :d4, :tick => 560
      config.timer :d5, :tick => 1
    end

    it 'allow timer 1' do
      source.should include('TCCR1B |= 1 << CS10;')
    end

  end

end

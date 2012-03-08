require 'spec_helper'

describe Raudi do

  it 'provides configuration methods without object' do
    Raudi.configure :atmega_328 do
      output :b3, :c3
      pullup :c2, :d6
      pc_interrupt :d1, :d2
    end

    controller = Raudi.controller
    controller.model_name.should == :atmega_328

    get_pin(:b, 3, controller).should be_output
    get_pin(:d, 6, controller).should be_pullup
    get_pin(:d, 2, controller).should be_pcint
  end

  it 'process raudi file' do
    Raudi.process('spec/examples/sample.raudi').should be_true
  end

end

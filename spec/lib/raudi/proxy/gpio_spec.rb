require 'spec_helper'

describe 'Proxy for gpio' do

  it 'output pins' do
    config.output :d0, :d3
    config.output :b0, :b2, :b3
    controller.ports(:d).output_pins.should have(2).items
    controller.ports(:b).output_pins[0].number.should == 0
  end

  it 'pullup pins' do
    config.pullup :c3, :c5, :b5
    controller.ports(:c).should have(2).pullup_pins
    controller.ports(:b).should have(1).pullup_pins
  end

end
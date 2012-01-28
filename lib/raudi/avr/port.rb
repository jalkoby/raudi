require 'raudi/avr/pin'
require 'raudi/avr/port_source'

module Raudi

  module AVR
    
    class Port

      attr_accessor :name, :pins, :source

      def initialize(name, pins)
        self.name = name.upcase
        self.pins = pins.map{|pin_number, states|  Pin.new(pin_number, states)}
        self.source = PortSource.new(self)
      end

    end

  end

end

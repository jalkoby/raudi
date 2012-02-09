require 'raudi/avr/pin'
require 'raudi/state_list'

module Raudi

  module AVR
    
    class Port
      
      include StateList

      attr_accessor :name, :pins, :interrupts, :pc_number

      def initialize(name, config)
        self.name = name.upcase
        self.pins = config['pins'].map{|pin_number, types|  Pin.new(self, pin_number, types)}
        self.pc_number= config['pc_number']
        self.interrupts = []
      end

      def add_interrupt(new_interrupt)
        self.interrupts << new_interrupt unless interrupts.include?(new_interrupt)
      end

      def pins(pin_number = nil)
        if pin_number
          pins.detect{|pin| pin.number == pin_number.to_i}
        else
          @pins
        end
      end

    end

  end

end

require 'raudi/avr/info'
require 'raudi/avr/pin'
require 'raudi/avr/port_source'
require 'raudi/avr/with_source'

module Raudi

  module AVR
    
    class Port

      include WithSource

      attr_accessor :name, :pins, :interrupts

      Info.pin_states.each do |common_state|
        define_method "#{common_state}_pins" do
          pins.select{|pin| pin.send("#{common_state}?")}
        end
      end

      def initialize(name, pins)
        self.name = name.upcase
        self.pins = pins.map{|pin_number, types|  Pin.new(self, pin_number, types)}
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

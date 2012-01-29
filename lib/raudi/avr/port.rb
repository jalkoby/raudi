require 'raudi/avr/info'
require 'raudi/avr/pin'
require 'raudi/avr/port_source'
require 'raudi/avr/with_source'

module Raudi

  module AVR
    
    class Port

      include WithSource

      attr_accessor :name, :pins

      Info.pin_states.each do |state|
        define_method "#{state}_pins" do
          pins.select{|pin| pin.current_state == state}
        end
      end

      def initialize(name, pins)
        self.name = name.upcase
        self.pins = pins.map{|pin_number, types|  Pin.new(self, pin_number, types)}
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

require 'raudi/avr/source'
require "raudi/avr/info"

module Raudi

  module AVR

    class PortSource < Source

      def to_c(code_place = :main)
        reset_source_text
        case code_place
        when :main
          process_gpio
          process_int
        when :interrupts
          port.int_pins.each do |pin|
            vector_name = "#{pin.to_c}_vect"
            interrupt_block vector_name
          end
        end
        super()
      end

      def process_gpio
        register_name = "DDR#{port.name}"
        bits = port.output_pins.map(&:number)
        write_bits(register_name, bits)

        register_name = "PORT#{port.name}"
        bits = port.pullup_pins.map(&:number)
        write_bits(register_name, bits)
      end

      def process_int
        register_name = "MCUCR"
        bits = port.int_pins.inject([]) do |bits, pin|
          pair = Info.interrupt_event(pin.state_params)
          pair.each_with_index do |bit_set, bit_number|
            bits << "ISC#{pin.state_number}#{bit_number}" if bit_set
          end
          bits
        end
        write_bits(register_name, bits)

        register_name = "GICR"
        bits = port.int_pins.map(&:to_c)
        write_bits(register_name, bits)
      end

    end

  end

end

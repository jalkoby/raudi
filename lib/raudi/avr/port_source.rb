require 'raudi/avr/source'

module Raudi

  module AVR

    class PortSource < Source

      def to_c(code_place = :main)
        reset_source_text
        case code_place
        when :main
          process_gpio
        end
        super()
      end

      def process_gpio
        unless(output_pins = port.output_pins).empty?
          source = "DDR#{port.name}"
          source << " |= "
          source << output_pins.map {|pin| "1 << #{pin.number}"}.join(' || ')
          code_line source
        end
        unless(pullup_pins = port.pullup_pins).empty?
          source = "PORT#{port.name}"
          source << " |= "
          source << pullup_pins.map {|pin| "1 << #{pin.number}"}.join(' || ')
          code_line source
        end
      end

    end

  end

end

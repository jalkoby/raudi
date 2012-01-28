require 'raudi/avr/source'

module Raudi

  module AVR

    class PortSource < Source

      attr_accessor :port

      def initialize(port)
        self.port = port
      end

      def startup
        source = ""
        source << output_config
        source
      end

      def output_config
        return "" if port.output_pins.empty?
        source = "DDR#{port.name}"
        source << " |= "
        source << port.output_pins.map {|pin| "1 << #{pin.number}"}.join(' || ')
        source << ";#{new_line}"
        source
      end

    end

  end

end

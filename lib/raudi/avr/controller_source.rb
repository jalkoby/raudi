require "raudi/avr/source"

module Raudi

  module AVR

    class ControllerSource < Source

      def to_c
        process_headers
        new_line
        each_port { |port| code_lines port.to_c(:interrupts)}
        function_block(:main) do
          each_port { |port| code_lines port.to_c}
          allow_interrupt
        end
        super
      end

      def process_headers
        controller.headers.each{ |name| code_line "#include <#{name}.h>", skip_semicolon: true }
      end

      def allow_interrupt
        code_line("sei();") if controller.with_interrupt
      end

      private

      def each_port(&block)
        controller.ports.each do |port|
          block.call(port)
        end
      end

    end

  end

end

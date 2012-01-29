require "raudi/avr/source"

module Raudi

  module AVR

    class ControllerSource < Source

      def process_headers
        controller.headers.each{ |name| code_line "#include <#{name}.h>", skip_semicolon: true }
      end

      def to_c
        process_headers
        new_line
        function_block(:main) do
          controller.ports.each do |port|
            code_lines port.to_c
          end
        end
        super
      end

    end

  end

end

require "raudi/avr/source"

module Raudi

  module AVR

    class ControllerSource < Source
      
      def initialize(controller)
        @controller = controller
      end

      def modules
        @controller.modules.inject("") do |source, module_name|
          source << "#include <#{module_name}.h>#{new_line}"
        end
      end

    end

  end

end

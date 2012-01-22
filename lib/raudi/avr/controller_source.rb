module Raudi

  module AVR

    class ControllerSource
      
      def initialize(controller)
        @controller = controller
      end

      def modules
        @controller.modules.inject("") do |source, module_name|
          source << "#include <#{module_name}.h>\n"
        end
      end

    end

  end

end
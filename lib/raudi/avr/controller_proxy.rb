module Raudi

  module AVR

    class ControllerProxy
      
      def initialize(controller)
        @controller = controller
      end

      def modules(*args)
        args.each do |param|
          case param
          when String
            next if param == ""
          when Symbol
            param = "avr/#{param}"
          else
            next
          end
          @controller.modules << param if allow_module?(param)
        end
      end

      def method_missing(method_name, *args)
        if @controller.respond_to("#{method_name}=")
          @controller.send("#{method_name}=", *args)
        else
          raise "Illegal property #{method_name}, check configuration file"
        end
      end

      private

      def allow_module?(module_name)
        AVR.modules.include?(module_name) and !@controller.modules.include?(module_name)
      end
    end

  end

end
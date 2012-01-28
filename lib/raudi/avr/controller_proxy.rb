module Raudi

  module AVR

    class ControllerProxy
      
      attr_accessor :controller

      def initialize(controller)
        self.controller = controller
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
          controller.modules << param if allow_module?(param)
        end
      end

      def output(*args)
        args.each do |arg|
          case arg
          when Symbol, String
            port_name = arg[/[a-z]+/i]
            raise "Port is not specified" unless port_name
            port_name.upcase!
            pin_number = arg[/\d+/]
            raise "Pin is not specified" unless pin_number
            controller.ports.each do |port|
              if port.name == port_name
                port.pins.each do |pin|
                  if pin.number == pin_number
                    pin.output!
                  end
                end
              end
            end
          end
        end
      end

      def method_missing(method_name, *args)
        if controller.respond_to?("#{method_name}=")
          controller.send("#{method_name}=", *args)
        else
          raise "Illegal property #{method_name}, check configuration file"
        end
      end

      private

      def allow_module?(module_name)
        AVR.modules.include?(module_name) and !controller.modules.include?(module_name)
      end
    end

  end

end

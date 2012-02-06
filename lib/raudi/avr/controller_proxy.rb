require 'raudi/avr/info'

module Raudi

  module AVR

    class ControllerProxy
      
      attr_accessor :controller

      def initialize(controller)
        self.controller = controller
      end

      def headers(*args)
        args.each do |param|
          case param
          when String
            next if param == ""
          when Symbol
            param = "avr/#{param}"
          else
            next
          end
          controller.headers << param if allow_header?(param)
        end
      end

      def eint(*args)
        set_interrupt(*args){|pin| pin.eint!}
      end

      def output(*args)
        set_pin_mode(*args){|pin| pin.output!}
      end

      def pullup(*args)
        set_pin_mode(*args){|pin| pin.pullup!}
      end

      def method_missing(method_name, *args)
        if controller.respond_to?("#{method_name}=")
          controller.send("#{method_name}=", *args)
        else
          raise "Illegal property #{method_name}, check configuration file"
        end
      end

      private

      def allow_header?(name)
        Info.headers.include?(name) and !controller.headers.include?(name)
      end

      def set_pin_mode(*args, &block)
        args.each do |arg|
          port_name = arg[/[a-z]+/i]
          raise "Port is not specified" unless port_name
          pin_number = arg[/\d+/]
          raise "Pin is not specified" unless pin_number
          port = controller.ports(port_name)
          raise "Port #{port_name} doesn't exists in controller" unless port
          pin = port.pins(pin_number)
          raise "Pin #{pin_number} doesn't exists in port #{port_name}" unless pin
          block.call(pin)
        end
      end

      def set_interrupt(*args, &block)
        set_pin_mode(*args) do |pin|
          headers :interrupt
          controller.with_interrupt = true
          block.call(pin)
        end
      end

    end

  end

end

require 'raudi/proxy/external_interrupt'
require 'raudi/proxy/gpio'
require 'raudi/proxy/headers'
require 'raudi/proxy/timer'

module Raudi

  module Proxy

    class Controller

      include ExternalInterrupt
      include GPIO
      include Headers
      include Timer

      attr_accessor :controller

      def initialize(controller, &block)
        self.controller = controller
        instance_eval(&block) if block_given?
      end

      private

      def get_pin(pin_name)
        port_name = pin_name[/[a-z]+/i]
        raise "Port is not specified" unless port_name
        pin_number = pin_name[/\d+/]
        raise "Pin is not specified" unless pin_number
        port = controller.ports(port_name)
        raise "Port #{port_name} doesn't exists in controller" unless port
        pin = port.pins(pin_number)
        raise "Pin #{pin_number} doesn't exists in port #{port_name}" unless pin
        pin
      end

      def method_missing(method_name, *args)
        if controller.respond_to?("#{method_name}=")
          controller.send("#{method_name}=", *args)
        else
          raise "Illegal property #{method_name}, check configuration file"
        end
      end

      def set_interrupt(*args)
        headers :interrupt
        controller.interrupt = true
        return if args.empty? or !block_given?
        args.each do |arg|
          yield arg
        end
      end

      def set_pin_mode(*args, &block)
        args.each do |arg|
          block.call(get_pin(arg))
        end
      end

    end

  end

end

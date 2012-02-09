module Raudi

  class Proxy
    
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

    def external_interrupt(*args)
      set_interrupt(*args) do |arg|
        next unless arg.is_a?(Hash)
        arg.each do |pin_name, interrupt_event|
          pin = get_pin(pin_name)
          pin.int!(interrupt_event)
          pin.port.add_interrupt :int
        end
      end
    end

    def pc_interrupt(*args)
      set_interrupt(*args) do |arg|
        pin = get_pin(arg)
        pin.pcint!
        pin.port.add_interrupt :pcint
      end
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
        block.call(get_pin(arg))
      end
    end

    def set_interrupt(*args, &block)
      args.each do |arg|
        headers :interrupt
        controller.with_interrupt = true
        block.call(arg)
      end
    end

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

  end

end

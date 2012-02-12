module Raudi

  module Proxy

    module ExternalInterrupt
      
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

    end

  end

end
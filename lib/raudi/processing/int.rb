module Raudi

  module Processing

    class Int < Base

      private
      
      def interrupts
        int_pins.each do |pin| 
          interrupt_block vector_name(pin.to_c) do
            insert_action(pin.to_c)
          end
        end
      end

      def config
        register_name = "EICRA"
        bits = []
        int_pins.each do |pin|
          bits += Info.interrupt_event(pin.state_params).to_bits(2, :prefix => "ISC#{pin.state_number}")
        end
        write_register(register_name, bits)

        register_name = "EIMSK"
        bits = int_pins.map(&:to_c)
        write_register(register_name, bits)
      end

      def can_process?
        int_present?
      end

    end

  end

end

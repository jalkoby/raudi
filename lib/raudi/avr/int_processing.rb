module Raudi

  module AVR

    class IntProcessing < Processing

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
        write_bits = []
        clear_bits = []

        int_pins.each do |pin|
          list = Info.interrupt_event(pin.state_params)
          list.each_with_index do |bit_set, bit_number|
            bit_name = "ISC#{pin.state_number}#{bit_number}"
            if bit_set
              write_bits << bit_name
            else
              clear_bits << bit_name
            end
          end
        end
        write_register(register_name, write_bits)
        clear_register(register_name, clear_bits)

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

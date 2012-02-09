module Raudi

  module Processing

    class PCInt < Base

      private

      def interrupts
        ports.each do |port|
          next unless port.pcint_present?
          interrupt_block vector_name("PCINT#{port.pc_number}")
        end
      end

      def config
        pc_ports = [] 
        ports.map do |port|
          next unless port.pcint_present?
          register_name = "PCMSK#{port.pc_number}"
          bits = port.pcint_pins.map(&:to_c)
          write_register(register_name, bits)

          pc_ports << "PCIE#{port.pc_number}"
        end

        register_name = "PCICR"
        write_register(register_name, pc_ports)
      end

    end

  end

end
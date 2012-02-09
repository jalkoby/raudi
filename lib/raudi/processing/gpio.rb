module Raudi

  module Processing

    class Gpio < Base
      
      private

      def config
        ports.each do |port|
          register_name = "DDR#{port.name}"
          bits = port.output_pins.map(&:number)
          write_register(register_name, bits)

          register_name = "PORT#{port.name}"
          bits = port.pullup_pins.map(&:number)
          write_register(register_name, bits)
        end
      end

    end

  end

end
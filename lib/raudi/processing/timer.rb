module Raudi

  module Processing

    class Timer < Base
      
      private

      def config
        timers.select(&:active).each do |timer|
          register_name = "TCCR#{timer.number}B"
          bits = timer.prescale.to_bits(3, :prefix => "CS#{timer.number}")
          write_register(register_name, bits)
        end
      end

    end

  end

end

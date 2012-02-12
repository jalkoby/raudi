module Raudi

  module Processing

    class Timer < Base
      
      private

      def config
        timer_pins.each do |timer_pin|
          register_name = "TCCR#{timer_pin.state_number}B"
          
        end
      end

    end

  end

end
module Raudi

  module Processing

    class Timer < Base
        
      private

      def active_timers
        timers.select(&:active)
      end

      def config
        active_timers.each do |timer|
          set_timer_mask(timer)
          set_mode(timer)
        end
      end

      def interrupts
        active_timers.each do |timer|
          next unless timer.interrupt
          prefix = "timer#{timer.number}"
          case
          when timer.normal?
            interrupt_block vector_name(prefix, "ovf") do

            end
          when timer.ctc?
            timer.mode_params.keys.each do |register_name|
              interrupt_block vector_name(prefix, "comp#{register_name}") do

              end
            end
          end
        end
      end

      def set_mode(timer)
        register_name = "TCCR#{timer.number}B"
        bits = timer.prescale.to_bits(3, :prefix => "CS#{timer.number}")
        bits << "WGM#{timer.number}2" if timer.ctc?
        write_register(register_name, bits)
      end

      def set_timer_mask(timer)
        return unless timer.interrupt   
        case
        when timer.normal?
          register_name = "TIMSK#{timer.number}"
          bits = ["TOIE#{timer.number}"]
          write_register(register_name, bits)
        end
      end

    end

  end

end

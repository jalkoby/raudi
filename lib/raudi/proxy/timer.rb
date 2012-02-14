module Raudi

  module Proxy

    module Timer

      def activate_timer(number, params = {})
        timer = get_tc_devise(number)
        timer.prescale = prepare_prescale(params[:prescale])
        base_tc_setting(timer, params)
      end

      def activate_counter(number, params = {})
        counter = get_tc_devise(number)
        counter.counter = get_counter_pin(number)
        base_tc_setting(counter, params)
      end

      private

      def base_tc_setting(devise, params)
        if params[:interrupt]
          devise.interrupt = true
          set_interrupt          
        end
        devise.active = true
      end

      def get_counter_pin(number)
        pin = controller.pins.detect { |pin| pin.can_be_counter?(number) }
        raise_timer_error(number, "can be counter") unless pin
        pin.counter!
        pin
      end

      def get_tc_devise(number)
        devise = controller.timers.detect{|devise| devise.number == number}
        raise_timer_error(number, "doesn't present") unless devise
        devise
      end

      def prepare_prescale(value)
        [1, 8, 64, 256, 1024].include?(value) ? value : 1
      end

      def raise_timer_error(number, message)
        raise "Timer/Counter #{number} #{message} in controller #{controller.model_name}"
      end
      
    end

  end

end

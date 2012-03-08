module Raudi

  module Proxy

    module Timer

      def activate_timer(number, params = {})
        timer = get_tc_devise(number)
        timer.prescale = prepare_prescale(params[:prescale]) || 1
        base_tc_setting(timer, params)
      end

      def activate_counter(number, params = {})
        counter = get_tc_devise(number)
        counter.counter = get_counter_pin(number)
        counter.prescale = prepare_prescale(params[:mode].to_s) || 6
        base_tc_setting(counter, params)
      end

      private

      def base_tc_setting(devise, params)
        [:a, :b].each do |number|
          if value = params[number] and devise.range.include?(value)
            devise.ctc!
            devise.mode_params[number] = value
          end
        end
        if params[:interrupt]
          devise.interrupt = true
          set_interrupt
        end
        devise.active = true
      end

      def get_counter_pin(number)
        pin = controller.pins.detect { |pin| pin.can_be_timer?(number) }
        raise_timer_error(number, "can be timer pin") unless pin
        pin.timer!
        pin
      end

      def get_tc_devise(number)
        devise = controller.timers.detect{|devise| devise.number == number}
        raise_timer_error(number, "doesn't present") unless devise
        devise
      end

      def prepare_prescale(value)
        Info.timers['prescale'][value]
      end

      def raise_timer_error(number, message)
        raise "Timer/Counter #{number} #{message} in controller #{controller.model_name}"
      end

    end

  end

end

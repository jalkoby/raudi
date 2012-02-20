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
        if params[:overflow]
          devise.overflow = true
          set_interrupt          
        end
        [:a, :b].each do |number|
          if value = params[number]
            devise.send("#{number}=", value) if devise.range.include?(value)
          end
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
        Info.timers['prescale'][value]
      end

      def raise_timer_error(number, message)
        raise "Timer/Counter #{number} #{message} in controller #{controller.model_name}"
      end
      
    end

  end

end

module Raudi

  module StateList

    Info.pin_states.each do |common_state|
      define_method "#{common_state}_pins" do
        pins.select { |pin| pin.send("#{common_state}?") }
      end

      define_method "#{common_state}_present?" do
        pins.any? { |pin| pin.send("#{common_state}?") }
      end
    end

    # PWM pin are timer with special configuration
    alias :all_timer_pins :timer_pins

    def timer_pins
      all_timer_pins.select { |pin| !pin.state_params[:pwm] }
    end

    def pwm_pins
      all_timer_pins.select { |pin| pin.state_params[:pwm] }
    end

  end

end
module Raudi

  module AVR

    module PinStates

      DELIMITER = '_'
      
      def self.included(klass)
        
        klass.class_eval do

          attr_accessor :states, :state, :state_params

          Info.pin_states.each do |pin_state|

            define_method :get_state do |pin_state|
              states.detect { |state| state =~ Regexp.new("\\A(#{pin_state})(_\d+)?") }
            end

            define_method :get_state! do |pin_state|
              valid_state = get_state(pin_state)
              raise "#{to_s} can be #{pin_state}" unless valid_state
              valid_state
            end

            define_method "#{pin_state}!" do |*args|
              self.state = get_state!(pin_state)
              self.state_params = args.first
            end

            define_method "#{pin_state}?" do |*args|
              self.state == get_state(pin_state)
            end

            define_method "can_be_#{pin_state}?" do |*args|
              return unless full_state = get_state(pin_state)
              if(number = args.first)
                return unless full_state[number.to_s]
              end
              true
            end

          end

        end

      end

      def state_number
        state.split(DELIMITER).last
      end

      def to_c
        if Info.gpio_states.include?(state)
          "PIN#{name}#{number}"
        else
          state.to_s.gsub(DELIMITER, '').upcase
        end
      end

      private

      def load_states(states)
        self.states = (Info.gpio_states + states).uniq
        self.state = self.states.first
      end

    end

  end

end

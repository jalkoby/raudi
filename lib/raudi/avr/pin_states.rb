module Raudi

  module AVR

    module PinStates
      
      def self.included(klass)
        klass.class_eval do
                    
          Info.common_pin_states.each do |common_state|

            define_method :get_state do |common_state|
              states.detect{|state| state.include? common_state}
            end

            define_method :get_state! do |common_state|
              valid_state = get_state(common_state)
              raise "#{to_s} can be #{common_state}" unless valid_state
              valid_state
            end

            define_method "#{common_state}!" do
              self.state = get_state!(common_state)
            end

            define_method "#{common_state}?" do
              self.state == get_state(common_state)
            end

          end
        end
      end

      def to_c
        if Info.pin_types['GPIO'].include?(state)
          "PIN#{name}#{number}"
        else
          state.to_s.upcase
        end
      end

      private

      def load_states(types)
        self.states = types.split.map do |type|
          if states = Info.pin_types[type]
            states
          else
            raise "Unsupported type '#{type}'" unless Info.pin_states.include?(type)
            type
          end         
        end.flatten

        self.state = states.first
      end

    end

  end

end

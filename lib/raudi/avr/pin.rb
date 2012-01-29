require 'forwardable'
require 'raudi/avr/info'

module Raudi

  module AVR

    class Pin

      extend Forwardable
      
      attr_accessor :port, :number, :states, :current_state

      def_delegator :port, :name

      Info.pin_states.each do |state|
        define_method "#{state}!" do
          raise "Pin #{name}#{number} can be #{state}" unless states.include?(state)
          self.current_state = state 
        end
      end

      def initialize(port, number, types)
        self.port = port
        self.number = number
        load_states(types)
      end

      def current_state
        @current_state ||= states.first
      end

      def to_s

      end

      private

      def load_states(types)
        self.states = types.split.map do |type|
          states = Info.pin_types[type]
          raise "Unsupported type '#{type}'" unless states
          states
        end.flatten
      end

    end

  end

end

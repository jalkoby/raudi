require 'forwardable'
require 'raudi/avr/info'
require "raudi/avr/pin_states"

module Raudi

  module AVR

    class Pin

      extend Forwardable
      include PinStates

      attr_accessor :port, :number

      def_delegator :port, :name

      def initialize(port, number, types)
        self.port = port
        self.number = number
        load_states(types)
      end

      def to_s
        "Pin #{name}#{number} <#{state}>"
      end

    end

  end

end

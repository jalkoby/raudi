require 'yaml'

module Raudi

  module AVR

    class Pin
      
      attr_accessor :number, :states

      class << self

        def valid_types
          {
            "GPIO" => %w{}
          }
        end

        def type_names
          valid_types.map(&:first)
        end

        def state_names
          valid_types.map(&:last).flatten
        end

      end


      def initialize(number, states)
        self.number = number
        self.states = states.split(',')
      end

    end

  end

end

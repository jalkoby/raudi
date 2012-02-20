module Raudi

  module AVR

    class Timer

      attr_accessor :a, :active, :b, :counter, :overflow, :name, :length, :prescale

      def initialize(name, params)
        self.name = name
        self.length = params['length']
      end

      def number
        name[/\d+/].to_i
      end

      def range
        0..max_number
      end

      def max_number
        2**length
      end

    end

  end

end

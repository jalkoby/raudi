module Raudi

  module AVR

    class Timer

      attr_accessor :active, :counter, :interrupt, :name, :length, :prescale

      def initialize(name, params)
        self.name = name
        self.length = params['length']
      end

      def number
        name[/\d+/].to_i
      end

    end

  end

end

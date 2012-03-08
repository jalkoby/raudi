module Raudi

  module AVR

    class Timer

      attr_accessor :active, :counter, :interrupt, :mode, :mode_params, :name, :length, :prescale

      [:normal, :ctc].each do |timer_mode|
        define_method("#{timer_mode}?") do
          self.mode == timer_mode
        end

        define_method("#{timer_mode}!") do
          self.mode = timer_mode
        end
      end

      def initialize(name, params)
        self.name = name
        self.length = params['length']
        self.normal!
      end

      def number
        name[/\d+/].to_i
      end

      def range
        0...max_number
      end

      def max_number
        2**length
      end

      def mode=(new_mode)
        if @mode != new_mode
          @mode = new_mode
          self.mode_params = {}
          self.interrupt = nil
        end
      end

    end

  end

end

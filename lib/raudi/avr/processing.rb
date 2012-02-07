require 'raudi/avr/state_list'

module Raudi

  module AVR

    class Processing

      include StateList

      attr_accessor :controller, :source

      class << self

        attr_accessor :processings

        def processings
          @processings ||= []
        end

        def inherited(klass)
          processings << klass
        end
      
      end

      def initialize(controller, source)
        self.controller = controller
        self.source = source
      end

      def generate_interrupts
        return unless can_process?
        interrupts
      end

      def generate_config
        return unless can_process?
        config
      end

      def pins
        ports.map(&:pins).flatten
      end

      def action_source(action_name)
        action_name = "#{action_name}_action"
        begin
          eval action_name
        rescue
          ''
        end
      end

      def method_missing(method_name, *args, &block)
        [source, controller].each do |delegate|
          return delegate.send(method_name, *args, &block) if delegate.respond_to?(method_name)
        end
        super
      end

      private

      def interrupts
      end

      def config
      end

      def can_process?
        true
      end

      def vector_name(prefix)
        vector_name = ""
        vector_name << prefix.upcase
        vector_name << "_vect"
      end

    end

  end

end

Dir[File.dirname(__FILE__) + '/*_processing.rb'].each{ |file_name| require file_name }

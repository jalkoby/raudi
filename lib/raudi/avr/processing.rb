require 'forwardable'
require 'raudi/avr/state_list'

module Raudi

  module AVR

    class Processing

      extend Forwardable
      include StateList

      attr_accessor :controller, :source

      def_delegator :controller, :ports
      def_delegator :source, :write_register
      def_delegator :source, :clear_register
      def_delegator :source, :interrupt_block

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

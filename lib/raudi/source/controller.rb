require 'raudi/source'
require 'raudi/processing'

module Raudi

  module Source

    class Controller < Base

      attr_accessor :controller

      def initialize(controller)
        self.controller = controller
      end

      def to_c
        process_headers
        new_line
        generate_interrupts
        function_block(:main) do
          generate_config
          user_setup
          allow_interrupt
          code_block('while(1)') do
            user_main
          end
        end
        super
      end

      def process_headers
        controller.headers.each{ |name| code_line "#include <#{name}.h>", skip_semicolon: true }
      end

      def allow_interrupt
        code_line("sei()") if controller.with_interrupt
      end

      private

      def generate_interrupts
        return unless controller.with_interrupt
        processings.each(&:generate_interrupts)
      end

      def generate_config
        processings.each(&:generate_config)
      end

      def processings
        Processing.list.map{|klass| klass.new(controller, self)}
      end

      def user_setup
        insert_action "SETUP"
      end

      def user_main
        insert_action "MAIN"
      end

    end

  end

end

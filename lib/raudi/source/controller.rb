require 'raudi/processing'
require 'raudi/source'
require 'raudi/source/interrupt'

module Raudi

  module Source

    class Controller < Base

      include Interrupt

      attr_accessor :controller

      def initialize(controller)
        self.controller = controller
      end

      def generate_headers
        controller.headers.each do |name|
          code_line "#include <#{name}.h>", skip_semicolon: true
        end
        new_line
      end

      def to_c
        generate_headers
        generate_interrupts

        function_block(:main) do
          generate_config
          insert_action :setup
          allow_interrupt
          code_block('while(1)') do
            insert_action :main
          end
        end

        source_text
      end

      private

      def generate_config
        processings.each(&:generate_config)
      end

      def processings
        Processing.list.map{|klass| klass.new(controller, self)}
      end

    end

  end

end

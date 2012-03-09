module Raudi

  module Source

    module Interrupt

      def allow_interrupt
        code_line("sei()") if controller.interrupt
      end

      def interrupt_block(*names, &block)
        interrupt_header = "ISR(#{vector_name(*names)})"
        new_block = lambda do
          insert_action(*names)
          block.call if block_given?
        end
        code_block(interrupt_header, &new_block)
        new_line
      end

      def generate_interrupts
        return unless controller.interrupt
        processings.each(&:generate_interrupts)
      end

      def vector_name(*args)
        vector_name = args.map(&:upcase).join('_')
        vector_name << "_vect"
      end

    end

  end

end

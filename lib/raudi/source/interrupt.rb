module Raudi

  module Source

    module Interrupt

      def allow_interrupt
        code_line("sei()") if controller.interrupt
      end

      def interrupt_block(vector_name, &block)
        interrupt_header = "ISR(#{vector_name})"
        code_block(interrupt_header, &block)
        new_line
      end

      def generate_interrupts
        return unless controller.interrupt
        processings.each(&:generate_interrupts)
      end

    end

  end

end

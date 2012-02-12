module Raudi

  module Source

    module Block

      def code_block(header)
        code_line header, skip_semicolon: true
        block_in
        yield if block_given?
        block_out 
      end

      def indent_count
        @indent_count || reset_indent_count
      end

      def indent_count=(value)
        @indent_count = value unless value < 0
      end

      def reset_indent_count
        @indent_count = 0
      end

      def indent_line
        "  " * indent_count 
      end

      def block_in
        code_line '{', skip_semicolon: true 
        self.indent_count += 1
      end

      def block_out
        self.indent_count -= 1
        code_line '}', skip_semicolon: true
      end

    end
  
  end

end
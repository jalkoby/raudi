module Raudi

  module CLang
    
    class ProgramBlock
      
      attr_accessor :intendation, :source

      def initialize(head_expression, intendation, &block)
        self.intendation = intendation
        self.source = code_line(head_expression)
        if block_given?
          open_quote
          block.call(self)
          close_quote
        end
      end

      def open_quote
        code_line("{")
        block_in
      end

      def close_quote
        block_out
        code_line("}")
      end

      def code_line(code)
        self. << (intendation + code + new_line)
      end

      def intend_count
        @intend_count ||= 0
      end

      def intend_count=(value)
        raise "Intendation is negative. Check all your block" if value < 0
        @intend_count = value
      end

      def intendation
        " " * 2 * intend_count
      end

      def block_in
        self.intend_count +=1
      end

      def block_out
        self.intend_count -=1
      end

      def new_line
        "\n"
      end

      def current_block
        @current_block || ""
      end

      # def source
      #   if @source and @source != ""
      #     if @source.include?("\n")
      #       @source
      #     else
      #       @source[-1] == ';' ? @source : @source + ";"
      #     end
      #   else
      #     ""
      #   end
      # end

    end

  end

end
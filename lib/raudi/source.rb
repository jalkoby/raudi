require 'raudi/source/action'
require 'raudi/source/bit_operations'
require 'raudi/source/block'
require 'raudi/source/variable'
require 'raudi/source/function'

module Raudi

  module Source
    
    class Base

      include Action
      include BitOperations
      include Block
      include Function
      include Variable

      attr_accessor :source_text

      def code_line(line, params = {})
        source_text << indent_line
        source_text << line
        source_text << ';' unless params[:skip_semicolon]
        source_text << new_line unless params[:same_line]
      end

      def code_lines(lines)
        lines.each_line{ |line| code_line(line, skip_semicolon: true, same_line: true) }
      end

      def new_line
        "\n"
      end

      def reset_source_text
        self.source_text = ""
      end

      def source_text
        @source_text || reset_source_text
      end

    end

  end

end

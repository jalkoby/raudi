require 'raudi/c/variable'
require 'raudi/c/function'

module Raudi

  module AVR
    
    class Source

      include Raudi::C::Variable
      include Raudi::C::Function

      attr_accessor :source_text, :indent_count

      def self.inherited(sub_class)
        words = sub_class.to_s.split('::')
        object_name = words.last.gsub('Source', '').underscore
        sub_class.class_eval do

          attr_accessor object_name.to_sym

          define_method :initialize do |source_object|
            self.send("#{object_name}=", source_object)
          end

        end
      end

      def new_line
        "\n"
      end

      def code_line(line, params = {})
        source_text << indent_line
        source_text << line
        source_text << ';' unless params[:skip_semicolon]
        source_text << new_line unless params[:same_line]
      end

      def code_lines(lines)
        lines.each_line{ |line| code_line(line, skip_semicolon: true, same_line: true) }
      end

      def source_text
        @source_text || reset_source_text
      end

      alias_method :to_c, :source_text

      def code_block(header)
        code_line header, skip_semicolon: true
        block_in
        yield if block_given?
        block_out 
      end

      def interrupt_block(vector_name, &block)
        interrupt_header = "ISR(#{vector_name})"
        code_block(interrupt_header, &block)
        new_line
      end

      def block_in
        code_line '{', skip_semicolon: true 
        self.indent_count += 1
      end

      def block_out
        self.indent_count -= 1
        code_line '}', skip_semicolon: true
      end
      
      def reset_source_text
        self.source_text = ""
      end

      def indent_count
        @indent_count || reset_indent_count
      end

      def reset_indent_count
        @indent_count = 0
      end

      def indent_line
        "  " * indent_count 
      end

      def insert_action(action_name)
        action_name = "#{action_name}_action"
        code = begin
          eval(action_name)
        rescue
          ''
        end
        code_lines code
      end

      def write_register(register_name, bits)
        unless bits.empty?
          source = register_name.to_s.upcase
          source << " |= "
          source << join_bits(bits)
          code_line(source)
        end
      end

      def clear_register(register_name, bits)
        unless bits.empty?
          source = register_name.to_s.upcase
          source << " &= "
          source << "~("
          source << join_bits(bits)
          source << ")"
          code_line(source)
        end
      end

      def join_bits(bits)
        bits.map{|bit| "1 << #{bit}"}.join(" | ")
      end

    end

  end

end

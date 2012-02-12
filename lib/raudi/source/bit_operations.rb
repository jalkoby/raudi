module Raudi
  
  module Source

    module BitOperations
      
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
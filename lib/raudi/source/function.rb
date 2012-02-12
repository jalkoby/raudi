module Raudi

  module Source

    module Function

      def function_block(name, params = {}, &block_source)
        function_header = generate_function_header(name, params)
        code_block(function_header, &block_source)
      end

      def generate_function_header(name, params = {})
        source = ''
        source << generate_result(name, params[:result])
      end

      def generate_result(name, result = nil)
        if result.is_a?(Hash)
          result[:type] ||= :void
          result[:name] = name
          generate_variable result
        else
          result ||= :void
          generate_variable name: name, type: result
        end
      end

      def function_arguments(params)
        arguments_line = "("
        arguments_line << if params
          params = [params] unless params.is_a? Array
          params.map do |param|
            argument = result_to_c(param)
            if param[:array]
              param[:array] = 1 unless param[:array].is_a?(Integer)
              argument << ('*' * param[:array])
            end
            argument << param[:name].to_s
          end.join(", ")
        else
          'void'
        end
        arguments_line << ")"
      end

    end

  end

end
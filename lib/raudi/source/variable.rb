module Raudi

  module Source

    module Variable
      
      def process_variable(variable)
        source = ""

        [:static, :const, :unsigned].each do |prefix|
          source << "#{prefix} " if variable[prefix] or variable[prefix.to_s]
        end

        source << variable[:type].to_s
        source << ' '

        variable[:pointer] ||= variable[:array]
        if variable[:pointer]
          variable[:pointer] = 1 unless variable[:pointer].is_a?(Integer)
          source << ('*' * variable[:pointer])
        end

        source << variable[:name].to_s
        source
      end

    end

  end

end
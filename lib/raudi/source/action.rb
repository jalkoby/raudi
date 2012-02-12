module Raudi
  
  module Source

    module Action
      
      def insert_action(action_name)
        action_name = "#{action_name}_action"
        code = begin
          eval(action_name)
        rescue
          ''
        end
        code_lines code
      end

    end

  end

end
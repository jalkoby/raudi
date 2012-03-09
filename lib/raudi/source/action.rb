module Raudi

  module Source

    module Action

      def insert_action(*names)
        code = Raudi.action[*names]
        code_lines(code) if code
      end

    end

  end

end

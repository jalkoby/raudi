require 'forwardable'

module Raudi

  module AVR
    
    module WithSource

      extend Forwardable

      def source
        @source ||= begin
          klass = eval("#{self.class}Source")
          klass.new(self)
        end
      end

      def_delegator :source, :to_c

    end

  end

end
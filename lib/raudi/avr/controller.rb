require 'raudi/avr/controller_proxy'
require 'raudi/avr/controller_source'

module Raudi

  module AVR

    class Controller
      
      attr_accessor :model_name, :modules, :source
      
      def initialize(model_name)
        self.model_name = model_name
        self.modules = []
        self.source = ControllerSource.new(self)
        yield ControllerProxy.new(self)
        Raudi.controller = self
      end

    end

  end

end
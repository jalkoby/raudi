require 'yaml'
require 'raudi/avr/controller_proxy'
require 'raudi/avr/controller_source'
require 'raudi/avr/port'

module Raudi

  module AVR

    class Controller
      
      attr_accessor :model_name, :modules, :source, :ports
      
      def initialize(model_name)
        self.model_name = model_name
        load_configuration_file
        self.modules = []
        self.source = ControllerSource.new(self)
        yield ControllerProxy.new(self)
        Raudi.controller = self
      end

      private

      def load_configuration_file
        path = File.dirname(__FILE__)
        path << '/configuration'
        path << "/#{model_name}.yaml"
        raise "Unknow controller model" unless File.exist?(path)
        ports = YAML.load_file(path)['ports']
        raise "Internal error, configuration file is invalid" unless ports.is_a?(Hash)
        self.ports = ports.map {|port_name, pins| Port.new(port_name, pins)}
      end

    end

  end

end

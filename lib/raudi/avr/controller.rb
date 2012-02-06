require 'yaml'
require 'raudi/avr/controller_proxy'
require 'raudi/avr/controller_source'
require 'raudi/avr/port'
require 'raudi/avr/with_source'

module Raudi

  module AVR

    class Controller
      
      include WithSource

      attr_accessor :model_name, :headers, :ports, :with_interrupt
      
      def initialize(model_name)
        self.model_name = model_name
        load_configuration_file
        self.headers = []
        yield ControllerProxy.new(self) if block_given?
        Raudi.controller = self
      end

      def ports(port_name = nil)
        if port_name
          @ports.detect{|port| port.name == port_name.to_s.upcase}
        else
          @ports
        end
      end

      private

      def load_configuration_file
        path = 'configuration'
        path << "/#{model_name}.yml"
        raise "Unknow controller model" unless File.exist?(path)
        ports = YAML.load_config_file(path)['ports']
        raise "Internal error, configuration file is invalid" unless ports.is_a?(Hash)
        self.ports = ports.map {|port_name, pins| Port.new(port_name, pins)}
      end

    end

  end

end

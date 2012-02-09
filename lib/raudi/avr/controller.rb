require 'yaml'
require 'forwardable'
require 'raudi/proxy'
require 'raudi/source/controller'
require 'raudi/avr/port'

module Raudi

  module AVR

    class Controller
      
      extend Forwardable

      attr_accessor :model_name, :headers, :ports, :with_interrupt
      
      def_delegator :source, :to_c
      
      def initialize(model_name)
        self.model_name = model_name
        load_configuration_file
        self.headers = []
        yield Proxy.new(self) if block_given?
        Raudi.controller = self
      end

      def ports(port_name = nil)
        if port_name
          @ports.detect{|port| port.name == port_name.to_s.upcase}
        else
          @ports
        end
      end

      def source
        @source ||= Source::Controller.new(self)
      end

      private

      def load_configuration_file
        path = 'configuration'
        path << "/#{model_name}.yml"
        raise "Unknow controller model" unless File.exist?(path)
        ports = YAML.load_file(path)['ports']
        raise "Internal error, configuration file is invalid" unless ports.is_a?(Hash)
        self.ports = ports.map {|port_name, config| Port.new(port_name, config)}
      end

    end

  end

end

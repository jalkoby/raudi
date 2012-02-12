require 'raudi/proxy/controller'
require 'raudi/source/controller'

module Raudi

  module AVR

    class Controller
      
      extend Forwardable

      attr_accessor :model_name, :headers, :ports, :with_interrupt
      
      def_delegator :source, :to_c
      
      def initialize(model_name, &block)
        self.model_name = model_name
        load_ports
        self.headers = []
        Proxy::Controller.new(self, &block) if block_given?
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

      def config
        @config ||= begin
          path = 'configuration'
          path << "/#{model_name}.yml"
          raise "Unknow controller model" unless File.exist?(path)
          YAML.load_file(path)
        end
      end

      def load_ports
        self.ports = config['ports'].map {|port_name, config| Port.new(port_name, config)}
      end

      def method_missing(method_name, *args, &block)
        if value = config[method_name.to_s]
          value
        else
          super
        end
      end

    end

  end

end

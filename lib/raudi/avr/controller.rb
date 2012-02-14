require 'raudi/proxy/controller'
require 'raudi/source/controller'
require 'raudi/state_list'

module Raudi

  module AVR

    class Controller
      
      extend Forwardable
      include Raudi::StateList

      attr_accessor :model_name, :headers, :ports, :timers, :interrupt
      
      def_delegator :source, :to_c
      
      def initialize(model_name, &block)
        self.model_name = model_name
        load_ports
        load_timers
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

      def pins
        ports.map(&:pins).flatten
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

      def load_timers
        self.timers = config['timers'].map{|timer_name, config| Timer.new(timer_name, config)}
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

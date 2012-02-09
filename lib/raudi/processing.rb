require 'raudi/state_list'

module Raudi

  module Processing

    class << self

      attr_accessor :list

      def list
        @list ||= []
      end

    end

    class Base

      include Raudi::StateList

      attr_accessor :controller, :source

      def self.inherited(klass)
        Processing.list << klass
      end

      def initialize(controller, source)
        self.controller = controller
        self.source = source
      end

      def generate_interrupts
        return unless can_process?
        interrupts
      end

      def generate_config
        return unless can_process?
        config
      end

      def pins
        ports.map(&:pins).flatten
      end

      def method_missing(method_name, *args, &block)
        [source, controller].each do |delegate|
          return delegate.send(method_name, *args, &block) if delegate.respond_to?(method_name)
        end
        super
      end

      private

      def interrupts
      end

      def config
      end

      def can_process?
        true
      end

      def vector_name(prefix)
        vector_name = ""
        vector_name << prefix.upcase
        vector_name << "_vect"
      end

    end

  end

end

Dir[File.dirname(__FILE__) + '/processing/*.rb'].each{ |file_name| require file_name }

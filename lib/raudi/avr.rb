require 'raudi/avr/controller'

module Raudi 
  
  module AVR

    class << self

      attr_accessor :configuration

      def configuration
        @configuration ||= YAML.load_file("configuration/avr.yaml")
      end

      def method_missing(name, *args)
        if result = configuration[name]
          result
        else
          super(name, *args)
        end
      end

      def modules
        @modules ||= begin
          hash_list = configuration['modules']
          collection = list.delete(:common).split
          hash_list.each do |namespace_name, namespace_modules|
            collection << namespace_modules.split.map{|module_name| "#{namespace_name}/#{module_name}"}
          end
          collection
        end
      end

    end

  end

end

module Raudi
    
  module Info

    class << self

      def config
        @config ||= YAML.load_file('configuration/avr.yml')
      end

      def method_missing(method_name, *args)
        if result = config[method_name.to_s]
          result
        else
          super(method_name, *args)
        end
      end

      def pin_states
        gpio_states + specific_pin_states
      end

      def headers
        @headers ||= begin
          list = []
          config['headers'].each do |namespace, headers|
            list += headers.map{|header| "#{process_namespace(namespace)}#{header}"}
          end
          list
        end
      end

      def interrupt_event(event_name)
        list = config['interrupts']['events'][event_name.to_s]
        raise "Undefined interrupt event - #{event_name}" unless list.is_a?(Array)
        list
      end

      private

      def process_namespace(name)
        (name == 'common') ? '' : name + '/'
      end

    end

  end

end

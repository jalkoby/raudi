module Raudi

  module AVR
    
    module Info
      
      class << self

        def configuration
          @configuration ||= YAML.load_file("configuration/avr.yml")
        end

        def method_missing(name, *args)
          if result = configuration[name]
            result
          else
            super(name, *args)
          end
        end

        def headers
          @headers ||= begin
            list = []
            configuration['headers'].each do |namespace, headers|
              list += headers.split.map{|header| "#{process_namespace(namespace)}#{header}"}
            end
            list
          end
        end

        def pin_types
          @pin_types ||= begin
            list = {}
            configuration['pin_types'].each do |type, states| 
              list[type] = states.split
            end
            list
          end
        end

        def pin_states
          @pin_states ||= pin_types.map{|type, states| states}.flatten
        end

        private

        def process_namespace(name)
          (name == 'common') ? '' : name + '/'
        end

      end

    end

  end

end
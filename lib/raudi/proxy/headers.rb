module Raudi

  module Proxy

    module Headers

      def headers(*args)
        args.each do |param|
          case param
          when String
            next if param == ""
          when Symbol
            param = "avr/#{param}"
          else
            next
          end
          controller.headers << param if allow_header?(param)
        end
      end

      private

      def allow_header?(name)
        Info.headers.include?(name) and !controller.headers.include?(name)
      end

    end

  end

end
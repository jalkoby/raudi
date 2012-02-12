module Raudi

  module Proxy

    module Timer

      def timer(pin_name, params = {})
        pin = get_pin(pin_name)
        params[:tick] = prepare_time(params[:tick])
        pin.timer!
        set_interrupt if params[:interrupt]
        pin.state_params = params
      end

      private

      def prepare_time(time)
        case time
        when Fixnum
          return time
        when String
          number = time.to_f
          suffix = time[/[smh]+/]
          case suffix
          when /s/i
            number *= 1000 
          when /m/i
            number *= 1000*60
          when /h/i
            number *= 1000*60*60
          end
          number = number.to_i
          return number unless number == 0
        end
        raise "Tick's period isn't set"
      end
      
    end

  end

end
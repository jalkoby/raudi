module Raudi

  module Proxy

    module GPIO

      def output(*args)
        set_pin_mode(*args){|pin| pin.output!}
      end

      def pullup(*args)
        set_pin_mode(*args){|pin| pin.pullup!}
      end

    end

  end

end
require 'raudi/avr/controller'

module Raudi 
  
  module AVR

    class << self

      def common_modules
        %w{alloca assert ctype errno inttypes math setjmp stdint stdio stdlib string}
      end

      def avr_modules
        %w{boot cpufunc eeprom fuse interrupt io lock pgmspace power 
          sfr_defs signature sleep version wdt}.map{|module_name| "avr/#{module_name}"}
      end

      def util_modules
        %w{atomic crc16 delay delay_basic parity setbaud twi}.map{|module_name| "util/#{module_name}"}
      end

      def modules
        common_modules + avr_modules + util_modules
      end

    end

  end

end
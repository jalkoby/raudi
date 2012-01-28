require 'spec_helper'

describe Raudi::AVR::Controller do

  context 'defining:' do

    context 'libs section:' do
      
      it 'specifing libs' do
        controller = klass.new :atmega_328 do |controller|
          controller.modules :io, 'foo_module', 'util/twi'
          controller.modules :wazza, 'math', 'avr/io'
        end
        controller.source.modules.should == "#include <avr/io.h>\n#include <util/twi.h>\n#include <math.h>\n"
      end

    end

    context 'pin section' do

      it 'set output pins' do
        controller = klass.new :atmega_328 do |config|
          config.output :d0, :d3, :c3, :u34
          config.output b: [0,2,3]
        end
        controller.source.startup_ports.should == "DDRB |= 1 << 0 || 1 << 2 || 1 << 3;\nDDRD |= 1 << 0 || 1 << 3;"
      end

    end

  end

end

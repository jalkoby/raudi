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

  end

end
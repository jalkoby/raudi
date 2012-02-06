require 'spec_helper'

describe Raudi::AVR::Pin do

  before :each do
    @port = Raudi::AVR::Port.new("C", [])
  end
  
  context 'generate c presentation' do
    
    context 'as gpio' do

      before :each do 
        @pin = Raudi::AVR::Pin.new(@port, 3, "GPIO")
      end
      
      it 'input' do
        @pin.to_c.should == "PINC3"
      end

      it 'output' do
        @pin.output!
        @pin.to_c.should == 'PINC3'
      end

      it 'pullup' do
        @pin.pullup!
        @pin.to_c.should == 'PINC3'
      end

    end

    it 'as eint' do
      @pin = klass.new(@port, 2, "GPIO eint_0")
      @pin.eint!
      @pin.to_c.should == "EINT_0"
    end

  end

end

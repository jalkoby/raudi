require 'spec_helper'

describe Raudi::AVR::Pin do

  before :each do
    @port = Raudi::AVR::Port.new("C", {'pins' => []})
  end
  
  context 'generate c presentation' do
    
    context 'as gpio' do

      before :each do 
        @pin = Raudi::AVR::Pin.new(@port, 3, [])
      end
      
      it 'input' do
        @pin.to_c.should == "PINC3"
        @pin.should be_input
      end

      it 'output' do
        @pin.output!
        @pin.to_c.should == 'PINC3'
        @pin.should be_output
      end

      it 'pullup' do
        @pin.pullup!
        @pin.to_c.should == 'PINC3'
        @pin.should be_pullup
      end

    end

    it 'as eint' do
      @pin = klass.new(@port, 2, ["int_0"])
      @pin.int!
      @pin.to_c.should == "INT0"
      @pin.should be_int
    end

  end

end

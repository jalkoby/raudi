require 'spec_helper'

describe Raudi do

  it 'provides configuration methods without object' do
    Raudi.configure :atmega_328 do
      output :b3, :c3
      pullup :c2, :d6
      pc_interrupt :d1, :d2
    end

    controller = Raudi.controller
    controller.model_name.should == :atmega_328

    get_pin(:b, 3, controller).should be_output
    get_pin(:d, 6, controller).should be_pullup
    get_pin(:d, 2, controller).should be_pcint
  end

  context 'output in file' do

    after :each do
      File.exists?(@expected_file).should be_true
      File.delete @expected_file
    end

    it 'use default case' do
      Raudi.process('spec/examples/sample.raudi').should be_true
      @expected_file = 'spec/examples/sample.c'
    end

    %w{--output -o}.each do |variant|
      it "specify custom output file with argument #{variant}" do
        @expected_file = 'foo.c'
        Raudi.process('spec/examples/sample.raudi', variant, @expected_file).should be_true
      end
    end

  end

end

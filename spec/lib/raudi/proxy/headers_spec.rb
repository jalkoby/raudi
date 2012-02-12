require 'spec_helper'

describe 'Proxy for headers' do

  it 'normal case' do
    config.headers 'util/twi'
    config.headers 'avr/io'
    controller.headers.should have(2).items
  end

  it 'use symbols' do
    config.headers :io, :boot
    controller.headers.should have(2).items
    controller.headers.should include("avr/io")
  end

  it 'remove duplication' do
    config.headers :io, 'avr/io', "avr/io"
    controller.headers.should have(1).item
    controller.headers.should include('avr/io')
  end

  it 'remove unknow header' do
    config.headers :wazza, 'avr/foo', 'sample'
    controller.headers.should be_empty
  end 

end
require 'spec_helper'

describe 'Proxy for headers' do

  it 'by default have io header' do
    controller.headers.should have(1).item
    controller.headers.should include('avr/io')
  end

  it 'normal case' do
    config.headers 'util/twi'
    controller.headers.should have(2).items
  end

  it 'use symbols' do
    config.headers :boot
    controller.headers.should have(2).items
    controller.headers.should include("avr/boot")
  end

  it 'remove duplication' do
    config.headers :boot, 'avr/boot', "avr/boot"
    controller.headers.should have(2).item
    controller.headers.should include('avr/boot')
  end

  it 'remove unknow header' do
    config.headers :wazza, 'avr/foo', 'sample'
    controller.headers.should_not include('avr/wazza')
    controller.headers.should_not include('avr/foo')
    controller.headers.should_not include('sample')
  end

end

require 'spec_helper'

describe 'Generation gpio code' do

  it 'output pins' do
    config.output :b2, :c3, :b5, :d2
    source.should include("DDRC |= 1 << 3;")
    source.should include("DDRB |= 1 << 2 | 1 << 5;")
    source.should include("DDRD |= 1 << 2;")
  end

  it 'pullup pins' do
    config.pullup :c3, :b3, :b2, :b4
    source.should include("PORTC |= 1 << 3;")
    source.should include("PORTB |= 1 << 2 | 1 << 3 | 1 << 4;")
  end

end
require 'spec_helper'

describe Raudi::AVR::Info do

  it 'define method by node of file' do
    klass.pin_states.should be_kind_of(Array)
  end

end
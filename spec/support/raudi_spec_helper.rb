module RaudiSpecHelper

  def self.included(klass)
    klass.let(:controller) { Raudi::AVR::Controller.new(:atmega_328) }
    klass.let(:config){ Raudi::Proxy::Controller.new(controller) }
    klass.let(:source){ controller.to_c }
  end

  def klass
    described_class
  end

  def get_pin(port, pin, custom_controller = nil)
    kontroller = custom_controller ? custom_controller : controller
    kontroller.ports(port).pins(pin)
  end

end

Raudi.action[:main] = <<AVR
_delay_ms(delay_time);
toggle_pin(PIN3);
AVR

Raudi.action[:setup] = <<AVR
int delay_time = 500;
AVR

class AvrController
  
  class << self
    
    def define(model_name)
      Raudi.controller = new(model_name)
      yield(Raudi.controller) if block_given?
    end
    
  end
  
  attr_accessor :libs
  
  def initialize(model_name)
    @model_name = model_name
    @libs = ['avr/io']
  end
  
  def add_lib(lib_name)
    @libs << lib_name
  end

end
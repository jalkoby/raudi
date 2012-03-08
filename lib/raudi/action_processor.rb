module Raudi

  class ActionProcessor

    attr_accessor :collection

    def initialize
      self.collection = {}
    end

    def [](key)
      collection[prepare_key(key)]
    end

    def []=(key, value)
      collection[prepare_key(key)] = value
    end

    private

    def prepare_key(key)
      if key.is_a?(String)
        key.to_sym
      else
        key
      end
    end

  end

end

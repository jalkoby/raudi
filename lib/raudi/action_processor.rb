module Raudi

  class ActionProcessor

    attr_accessor :collection

    def initialize
      self.collection = {}
    end

    def [](*keys)
      collection[prepare_key(*keys)]
    end

    def []=(*keys, value)
      collection[prepare_key(*keys)] = value
    end

    private

    def prepare_key(*keys)
      number = if keys.last.is_a?(Fixnum)
        keys.pop
      end

      key = keys.map{|key| key.to_s.downcase}.join('_')
      key = key_alias(key)

      key << number.to_s if number
      key.to_sym
    end

    def key_alias(key)
      {
        'interrupt' => 'int'
      }[key] or key
    end

  end

end

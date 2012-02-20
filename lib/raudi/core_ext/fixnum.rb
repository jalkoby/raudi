Fixnum.class_eval do
  
  def to_bits(length, options = {})
    if prefix = options[:prefix]
      length.times.inject([]) do |list, index|
        if self[index] == 1
          list << "#{prefix}#{index}"
        end
        list
      end
    else
      length.times.map{ |index| self[index] == 1 }
    end
  end

end

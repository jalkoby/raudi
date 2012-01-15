require 'raudi/c_converter'

module SourceGenerator

  include CConverter

  def add_block(head_code, &block)
    block_code = code_line(head_code)
    block_code << open_quote
    block_code << block.call
    block_code << close_quote
  end

  def function_block(name, options = {})
    function_title = result_to_c(options[:result])
    function_title << name.to_s
    function_title << arguments_to_c(options[:args])
    if block_given?
      add_block(function_title){ yield }
    else
      function_title << ";"
    end
  end

  def open_quote
    quote = intendation + "{" + new_line
    block_in
    quote
  end

  def close_quote
    block_out
    intendation + "}" + new_line
  end

  def code_line(code)
    intendation + code + new_line
  end

  def intend_count
    @intend_count ||= 0
  end

  def intend_count=(value)
    raise "Intendation is negative. Check all your block" if value < 0
    @intend_count = value
  end

  def intendation
    " " * 2 * intend_count
  end

  def block_in
    self.intend_count +=1
  end

  def block_out
    self.intend_count -=1
  end

  def new_line
    "\n"
  end

end
# require 'raudi/c_converter'

# module SourceGenerator

#   include CConverter

#   attr_accessor :current_block

#   def add_block(head_code, &block)
#     parent_block = current_block
#     self.current_block = ""
#     code_line(head_code)
#     open_quote
#     block.call
#     close_quote
#     self.current_block = parent_block + current_block
#   end

#   def function_block(name, options = {})
#     function_title = result_to_c(options[:result])
#     function_title << name.to_s
#     function_title << arguments_to_c(options[:args])
#     if block_given?
#       add_block(function_title){ yield }
#     else
#       function_title << ";"
#     end
#   end





# end
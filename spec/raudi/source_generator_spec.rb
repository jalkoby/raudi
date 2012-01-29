# require 'spec_helper'

# describe SourceGenerator do

# pending 'wait until essential isnt complete'
# #   context "function generation" do

# #     context "without block" do

# #       it "without paramters and result" do
# #         source = ActionProcessor.function_block(:foo)
# #         source.should == "void foo();"
# #       end

# #       it 'with result and without paramters' do
# #         source = ActionProcessor.function_block(:foo, :result => :int)
# #         source.should == "int foo();"
# #       end

# #       it 'with result and paramters' do
# #         source = ActionProcessor.function_block(:foo, 
# #           {
# #             result: {type: :int, array: 2, static: true},
# #             args: 
# #             [
# #               {name: "param1", type: :int, array: true },
# #               {name: "param2", type: :char},
# #               {name: "param3", type: :boolean}
# #             ]
# #           }
# #         )
# #         source.should == "static int foo(int *param1, char param2, boolean param3);"
# #       end

# #     end

# #     context "with block" do

# #       it 'generate simple function' do
# #         source = ActionProcessor.function_block(:max, {result: :int, args: 
# #           [
# #             {type: :int, name: :a},
# #             {type: :int, name: :b}
# #           ]
# #         }) do
# #           add_block("if(a > b)"){ code_line("return a;") }
# #           add_block("else if(b > a)"){ code_line("return b;") }
# #           add_block("else"){ code_line("return 0;") }
# #         end
# #         source.should == "int max(int a, int b)
# # {
# #   if(a > b)
# #   {
# #     return a;
# #   }
# #   else if(b > a)
# #   {
# #     return b;
# #   }
# #   else
# #   {
# #     return 0;
# #   }
# # }
# # "
# #       end

# #     end

# #   end


# end
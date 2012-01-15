describe SourceGenerator do

  context "function generation" do

    it "without paramters, result and block" do
      source = ActionProcessor.function_block(:foo){ "" }
      source.should == "void foo();"
    end

    it 'with result, without paramters and block' do
      source = ActionProcessor.function_block(:foo, :result => :int)
      source.should == "int foo();"
    end

  end


end
describe SourceGenerator do

  context "function generation" do

    context "without block" do

      it "without paramters and result" do
        source = ActionProcessor.function_block(:foo)
        source.should == "void foo();"
      end

      it 'with result and without paramters' do
        source = ActionProcessor.function_block(:foo, :result => :int)
        source.should == "int foo();"
      end

      it 'with result and paramters' do
        source = ActionProcessor.function_block(:foo, 
          {
            result: {type: :int, array: 2, static: true},
            args: 
            [
              {name: "param1", type: :int, array: true },
              {name: "param2", type: :char},
              {name: "param3", type: :boolean}
            ]
          }
        )
        source.should == "static int** foo(int* param1, char param2, boolean param3);"
      end

    end

  end


end
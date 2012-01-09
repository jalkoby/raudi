describe Raudi do

  it 'should generate source code' do
    output = Raudi.generate('examples/config.rb', 'examples/actions.raudi')
    expected_ouput = File.open('examples/result.c')
    output.should == expected_ouput.read
  end

end
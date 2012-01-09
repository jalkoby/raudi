module ActionProcessor
  
  class << self
    
    def generate_source(actions_file)
      raise %q{Controller isn't specified in config.rb file} unless Raudi.controller
      define_actions(actions_file)
      output = ''
      output << append_libs(Raudi.controller.libs)
      output << block_delimiter
      output << main_block
    end
    
    def append_libs(libs)
      libs.map do |lib_name| 
        lib_name = lib_name.to_s
        lib_name << '.h' unless lib_name =~ /\.h$/
        "#include <#{lib_name}>"
      end.join("\n")
    end
    
    def block_delimiter
      "\n"
    end
    
    def define_actions(actions_file)
      File.open(actions_file) do |file|
      end
    end
    
  end

end
require 'raudi/source_generator'

module ActionProcessor

  class << self

    include SourceGenerator

    def generate_source(actions_file)
      raise %q{Controller isn't specified in config.rb file} unless Raudi.controller
      define_actions(actions_file)
      output = ''
      output << append_libs(Raudi.controller.libs)
      output << new_line
      output << main_block
    end

    def append_libs(libs)
      libs.map do |lib_name|
        lib_name = lib_name.to_s
        lib_name << '.h' unless lib_name =~ /\.h$/
        "#include <#{lib_name}>" + new_line
      end.join
    end

    def main_block
      partial = function_block(:main) do
        add_block("while(1)") do
          code_line("")
        end
      end
    end

    def define_actions(actions_file)
      File.open(actions_file) do |file|
      end
    end

  end

end
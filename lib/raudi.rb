require 'forwardable'
require 'yaml'
require 'raudi/action_processor'
require 'raudi/core_ext'
require 'raudi/info'
require 'raudi/avr'

module Raudi

  class << self

    attr_accessor :controller

    def version
      "0.0.2"
    end

    def configure(model_name, &block)
      Raudi::AVR::Controller.new(model_name, &block)
    end

    def action
      @action ||= Raudi::ActionProcessor.new
    end

    def process(*args)
      return unless filename = check_filename(args)
      begin
        load filename
        return write_file(filename, args)
      rescue Exception => e
        puts e.message
      end
      false
    end

    private

    def check_filename(args)
      filename = args.delete_at(0)
      return unless filename
      return unless File.exists?(filename)
      return unless filename =~ /.*\.raudi$/i
      filename
    end

    def param_alias(param)
      {'--output' => '-o'}[param] or param
    end

    def write_file(source_path, args)
      return unless source = controller.to_c
      output = source_path.gsub(/\.raudi$/i, '.c')
      args.each_with_index do |param, index|
        next unless param_alias(param) == '-o'
        custom_output = args[index + 1]
        output = custom_output if custom_output
        break
      end
      File.open(output, 'w') {|f| f.write(source) }
      true
    end

  end

end

def action
  Raudi.action
end

def configure(*args, &block)
  Raudi.configure(*args, &block)
end

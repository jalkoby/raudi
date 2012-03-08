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
      "0.0.1"
    end

    def configure(model_name, &block)
      Raudi::AVR::Controller.new(model_name, &block)
    end

    def action
      @action ||= Raudi::ActionProcessor.new
    end

    def process(*args)
      return unless filename = check_filename(args.first)
      begin
        load filename
        if source = controller.to_c
          output_filename = File.basename(filename, '.raudi') + '.c'
          File.open(output_filename, 'w') {|f| f.write(source) }
          return true
        end
      rescue Exception => e
        puts e.message
      end
      false
    end

    private

    def check_filename(filename)
      return unless filename
      return unless File.exists?(filename)
      return unless filename =~ /.*\.raudi$/
      filename
    end

  end

end

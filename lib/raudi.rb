require 'raudi/extentions'
require 'raudi/action_processor'
require 'raudi/avr'

module Raudi

  class << self

    attr_accessor :controller

    def version
      "0.0.1"
    end

    def generate(config_file, actions_file)
      absolute_config_path = File.expand_path(config_file)
      absolute_actions_path = File.expand_path(actions_file)
      raise 'Create configuration file config.rb before' unless File.exists?(absolute_config_path)
      raise 'Create actions file actions.raudi before' unless File.exists?(absolute_actions_path)
      load(absolute_config_path)
      ActionProcessor.generate_source(absolute_config_path)
    end

  end

end

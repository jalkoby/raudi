require 'ruby-debug'
require 'support/raudi_spec_helper'

RSpec.configure do |config|
  config.include RaudiSpecHelper
  
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

require 'ruby-debug'

module SupportHelpers

  def klass
    described_class
  end

end

load('spec/test_actions.rb')

RSpec.configure do |config|
  config.include SupportHelpers
end

require 'ruby-debug'

module SupportHelpers

  def klass
    described_class
  end

end


RSpec.configure do |config|
  config.include SupportHelpers
end

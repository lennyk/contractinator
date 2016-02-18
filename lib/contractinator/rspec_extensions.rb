require_relative 'rspec_extensions/double'

module Contractinator
  ::RSpec::Mocks::Double.include(RSpecExtensions::Double)
end

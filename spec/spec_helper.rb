$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'contractinator'

require_relative 'support/rspec_runner'
require_relative 'support/matchers'

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.include_chain_clauses_in_custom_matcher_descriptions = true
  end
end

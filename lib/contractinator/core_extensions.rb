require 'contractinator/core_extensions/array'
require 'contractinator/core_extensions/class'
require 'contractinator/core_extensions/hash'
require 'contractinator/core_extensions/object'
require 'contractinator/core_extensions/symbol'
require 'contractinator/core_extensions/string'
require 'contractinator/core_extensions/test_double'

require 'rspec/mocks/test_double'

module Contractinator
  ::Array.include(CoreExtensions::Array)
  ::Class.include(CoreExtensions::Class)
  ::Hash.include(CoreExtensions::Hash)
  ::Object.include(CoreExtensions::Object)
  ::Symbol.include(CoreExtensions::Symbol)
  ::RSpec::Mocks::TestDouble.include(CoreExtensions::TestDouble)
end

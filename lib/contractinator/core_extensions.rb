require 'contractinator/core_extensions/object'
require 'contractinator/core_extensions/array'

module Contractinator
  ::Object.include(CoreExtensions::Object)
  ::Array.include(CoreExtensions::Array)
end

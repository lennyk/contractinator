require 'contractinator/core_extensions/object'
require 'contractinator/core_extensions/array'
require 'contractinator/core_extensions/class'
require 'contractinator/core_extensions/symbol'

module Contractinator
  ::Object.include(CoreExtensions::Object)
  ::Array.include(CoreExtensions::Array)
  ::Symbol.include(CoreExtensions::Symbol)
  ::Class.include(CoreExtensions::Class)
end

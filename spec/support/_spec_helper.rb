require 'contractinator'

RSpec.configure do |config|
  config.include Contractinator::ContractHelpers

  config.after(:suite) do
    puts
    puts Contractinator::Contract.messages
    puts
    puts "#{Contractinator::Contract.fulfilled_set.count} fulfilled"
    puts
    puts "#{Contractinator::Contract.unmatched_created.count} unfulfilled"
  end
end

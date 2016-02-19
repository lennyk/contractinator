RSpec::Matchers.define :have do |number|
  match do |output|
    output.include? "#{number} #{@type}"
  end

  chain(:unfulfilled_contracts) do
    @type = 'unfulfilled'
  end

  chain(:fulfilled_contracts) do
    @type = 'fulfilled'
  end
end

RSpec::Matchers.define :contain_contract do |content|
  match do |output|
    output.include? content
  end
end

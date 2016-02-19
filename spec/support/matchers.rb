RSpec::Matchers.define :have do |number|
  chain(:fulfilled_contracts) do
    match do |output|
      output.include? "#{number} fulfilled,"
    end
  end

  chain(:unfulfilled_contracts) do
    match do |output|
      output.include? "#{number} unfulfilled,"
    end
  end
end

RSpec::Matchers.define :contain_contract do |content|
  match do |output|
    output.include? content
  end
end

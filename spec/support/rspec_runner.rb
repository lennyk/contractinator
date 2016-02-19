# https://github.com/brianauton/rspec-contracts
# also MIT license

require "tmpdir"

def spec_data(text)
  @spec_data ||= ""
  @spec_data += text
end

def spec_result
  @spec_result ||= Dir.mktmpdir do |dir|
    File.write "#{dir}/spec_helper.rb", File.read(File.join(File.dirname(__FILE__), '_spec_helper.rb'))
    File.write "#{dir}/my_spec.rb", @spec_data
    `rspec --options - -r #{dir}/spec_helper.rb #{dir}/my_spec.rb`
  end
end

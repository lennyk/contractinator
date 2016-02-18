# Contractinator

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'contractinator'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install contractinator
    
Then inform RSpec that you'd like to use contractinator by adding something like the following to your spec_helper.rb

```
require 'contractinator'

RSpec.configure do |config|
  config.include Contractinator::ContractHelpers

  # By default contractinator extends rspec's test doubles.
  # You don't have to use rspec's doubles TODO: explain how
  # to use other mocks.
  config.mock_with :rspec
  
  # After the suite is done, warn the user about all the
  # unbalanced contracts. 
  config.after(:suite) do
    puts
    puts Contractinator::Contract.messages
    puts
    puts "#{Contractinator::Contract.fulfilled_set.count} fulfilled contracts"
  end
end
```

## Usage

### Creating a Contract
There are several ways to document a provider's behavior. The easiest is to use the `stipulate` and `agree` matchers.

In the spec for a consumer, for example a rails controller, you might have

```
it 'assigns a new entry' do
  stipulate(Entry).must receive(:new).and_return(entry)
  get :new
  expect(response).to be_success
  expect(assigns[:entry]).to eq(entry)
end
```

This sets the expectation that Entry.new will be called, and stubs it out to return `entry`. Now you should get a warning in your rspec output that looks like this:

```
unfulfilled contract 'Entry.new -> entry'
   at spec/controllers/entries_controller_spec.rb:45:in `block (3 levels) in <top (required)>'
```

The next step is to make sure that contract is fulfilled by something. So we'll switch over to the model spec

```
describe '.new' do
  it { agree(Entry, :new).will be_a(Entry) }
end
```

This calls new on Entry and asserts that it is_a Entry, and fulfills a contract of the form `Entry.new -> entry`. Since this matches the one from above, your spec output won't show the unmatched on anymore, but will increment the fulfilled contracts message.

### Less straight-forward contracts
Not every contract in an application is so easy to specify. For example, a view spec which assigns a local variable has an agreement with a controller to assign that variable. Some other matchers available:

```
assign_contract('entries#new', :entry, entry)
flash_contract('entries#create', :notice, 'Great Success!') if flash_enabled
```

In these two cases, the method both does the side effect (assigning a variable for a view spec or setting a flash message), and also creates a matching contract. There isn't a corresponding fulfillment matcher for anything else yet, so you have to fulfill them manually. I do this like so, in my controller spec:

```
describe 'get :new' do
  it { fulfills 'entries#new assign @entry'   }
  it do 
  	# actual test which reflects this fulfillment
  end
end
```

### Free-form contracts
Sometimes I think of things that need a contract that I have no matchers for, and all I really want is a smart comment. I'm using this for a routing contract relationship now. In that case, you can do this:

```
 # this is a contract that might be created
 # by a link in a view spec for example
 Contractinator::Contract.require("get / routes")

```

And fulfill it with

```
it { fulfills('get / routes') }
```

All that matters for the contract to be fulfilled is that the string matches, so in this case contractinator is almost acting as merely a smart comment.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/contractinator. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


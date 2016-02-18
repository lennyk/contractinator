module Contractinator
  module Contract
    extend self

    @created = {}
    @fulfilled = {}

    def require(argument)
      @created[argument] = caller.find do |str|
        str =~ /_spec\.rb/
      end
    end

    def fulfill(argument)
      @fulfilled[argument] = caller.find do |str|
        str =~ /_spec\.rb/
      end
    end

    def created_set
      Set.new(@created.keys)
    end

    def fulfilled_set
      Set.new(@fulfilled.keys)
    end

    def unmatched_created
      unmatched_keys.intersection(created_set)
    end

    def unmatched_fulfilled
      unmatched_keys.intersection(fulfilled_set)
    end

    def unmatched_keys
      created_set ^ fulfilled_set
    end

    def validate
      unmatched_keys.empty?
    end

    def messages
      messages = []
      unmatched_created.map do |item|
        messages << "unfulfilled contract '#{item}'"
        messages << "   at #{@created[item]}"
      end

      unmatched_fulfilled.map do |item|
        messages << "excess fulfillment '#{item}'"
        messages << "   at #{@fulfilled[item]}"
      end
      messages
    end
  end
end

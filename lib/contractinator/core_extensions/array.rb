module Contractinator
  module CoreExtensions
    module Array
      def contract_inspect
        values = map(&:contract_inspect).join(', ')
        "[#{values}]"
      end
    end
  end
end

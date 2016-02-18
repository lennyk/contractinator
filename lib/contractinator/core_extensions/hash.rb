module Contractinator
  module CoreExtensions
    module Hash
      def contract_inspect
        values = map do |key, value|
          "#{key.contract_inspect}=>#{value.contract_inspect}"
        end.join(', ')
        "{#{values}}"
      end
    end
  end
end

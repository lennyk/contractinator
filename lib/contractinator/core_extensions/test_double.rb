module Contractinator
  module CoreExtensions
    module TestDouble
      def contract_inspect
        @name.to_s
      end
    end
  end
end

module Contractinator
  module CoreExtensions
    module Class
      def contract_inspect
        class_contract_inspect
      end

      def class_contract_inspect
        to_s
      end

      def instance_contract_inspect
        to_s.underscore
      end
    end
  end
end

module Contractinator
  module CoreExtensions
    module Object
      def contract_inspect
        instance_contract_inspect
      end

      def class_contract_inspect
        self.class.to_s
      end

      def instance_contract_inspect
        self.class.to_s.underscore
      end
    end
  end
end

module Contractinator
  module CoreExtensions
    module Object
      def try msg, *args, &block
        send(msg, *args, &block)
      end

      def contract_inspect
        instance_contract_inspect
      end

      def class_contract_inspect
        self.class.class_contract_inspect
      end

      def instance_contract_inspect
        self.class.instance_contract_inspect
      end
    end
  end
end

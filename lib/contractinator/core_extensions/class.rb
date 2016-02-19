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
        class_contract_inspect.gsub(/([a-z])([A-Z])/) do |p, n|
          "#{p}_#{n.downcase}"
        end.downcase
      end
    end
  end
end

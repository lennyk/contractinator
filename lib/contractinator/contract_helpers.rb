module Contractinator
  module ContractHelpers
    def fmt_dbl(dbl)
      dbl.contract_inspect
    end

    def stipulate(dbl)
      ContractAdapter.new(dbl, self)
    end

    def inject_contract(controller, name, dbl)
      dbl_name = fmt_dbl(dbl).to_s.classify
      Contractinator::Contract.require(
        "#{controller.controller_name}_controller.#{name} injected #{dbl_name}"
      )
      controller.send("#{name}=", dbl)
    end

    def assign_contract(where, name, object)
      Contractinator::Contract.require("#{where} assign @#{name}")
      assign(name, object)
    end

    def flash_contract(where, key, value)
      Contractinator::Contract.require("#{where} flash[#{key.inspect}]")
      flash[key] = value
    end

    def render_contract(who)
      Contractinator::Contract.require("#{who} render template")
      render
    end

    def agree(obj, method, *args)
      FulfillmentAdapter.new(self, obj, method, args)
    end

    def fulfill(*args, &block)
      Contractinator::Contract.fulfill(*args, &block)
      RSpec::Matchers.define "fulfill_#{args.first}" do
        match { true }
        description do
          "fulfill #{args.first.inspect}"
        end
      end
      expect(true).to send("fulfill_#{args.first}")
    end
    alias_method :fulfills, :fulfill

    def xfulfills(*args, &block)
      # noop
    end

    module Shared
      def contract_message_signature(dbl, msg, args, value)
        if args.try(:any?)
          "#{fmt_dbl dbl}.#{msg}(#{fmt_args args}) -> #{fmt_args value}"
        else
          "#{fmt_dbl dbl}.#{msg} -> #{fmt_args value}"
        end
      end

      def fmt_dbl(*args)
        @context.fmt_dbl(*args)
      end

      def fmt_args(args)
        args.map do |x|
          fmt_dbl(x)
        end.join(',  ')
      end

      def customization(matcher, named)
        matcher.
          instance_variable_get('@recorded_customizations').
          find do |x|
            x.instance_variable_get('@method_name').to_s == named.to_s
          end.try(:instance_variable_get, '@args')
      end
    end

    class FulfillmentAdapter
      include Shared

      def initialize(context, object, method, args)
        @object = object
        @context = context
        @method = method
        @args = args
      end

      def will(matcher)
        @context.expect(@object.send(@method, *@args)).to(matcher)
        if matcher.is_a?(RSpec::Matchers::BuiltIn::BeAKindOf)
          stand_in = @context.double(matcher.expected.instance_contract_inspect)
        else
          stand_in = matcher.expected
        end
        @context.fulfills(
          contract_message_signature(@object, @method, @args, [stand_in])
        )
      end
    end

    class ContractAdapter
      include Shared

      def initialize(object, context)
        @object = object
        @context = context
      end

      def must(matcher)
        @matcher = matcher

        if matcher.is_a?(RSpec::Rails::Matchers::RoutingMatchers::RouteToMatcher)
          contract_route_to_matcher
        else
          contract_receive_matcher
        end
      end

      private

      def contract_route_to_matcher
        @expected = @matcher.instance_variable_get('@expected').with_indifferent_access
        create_route_contract
        create_route_expectation
      end

      def contract_receive_matcher
        @message      = @matcher.instance_variable_get('@message')
        @arguments    = customization(@matcher, :with)
        @return_value = customization(@matcher, :and_return)

        create_contract
        create_expectation
      end

      def create_route_contract
        method     = @object.keys.first
        controller = @expected[:controller]
        action     = @expected[:action]

        params = @expected.except(:controller, :action)
        if params.keys.any?
          Contractinator::Contract.require("#{method} #{controller}##{action} #{params}")
        else
          Contractinator::Contract.require("#{method} #{controller}##{action}")
        end
      end

      def create_route_expectation
        @context.expect(@object).to @context.route_to(@expected)
      end

      def create_contract
        args  = @arguments
        dbl   = @object
        msg   = @message
        value = @return_value

        Contractinator::Contract.require(contract_message_signature(dbl, msg, args, value))
      end

      def create_expectation
        @context.expect(@object).to @matcher.at_least(:once)
      end
    end
  end
end

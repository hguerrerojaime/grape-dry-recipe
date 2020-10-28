# frozen_string_literal: true

# Business Class - extends instance with validation and transaction capabilities
module BusinessClass
  def service_method(options = {})
    @service_method_options = {}.merge(options)
  end

  def service_methods
    @service_methods ||= {}
  end

  def self.validate_contract(params, contract, error_message: 'invalid input')
    validated_params = contract.call(params)
    if validated_params.errors.any?
      errors = validated_params.errors.to_h
      raise Exceptions::ValidationException.new(error_message, errors)
    end
    validated_params
  end

  private

  def method_added(method_name)
    if @service_method_options
      service_methods[method_name] = @service_method_options
      enhance!(method_name)
    end
    @service_method_options = nil
    super
  end

  def enhance!(method_name)
    options = service_methods[method_name]
    proxy = Module.new do
      define_method(method_name) do |params|
        validated_params = if options[:contract]
                             BusinessClass.validate_contract(
                               params,
                               Container.resolve("contracts.#{options[:contract]}"),
                               error_message: options[:error_message]
                             )
                           else
                             params
                           end
        if options[:transaction]
          database = Container.resolve(:database)
          transaction_opts = options[:transaction]
          transaction_opts = {} if options[:transaction].is_a?(TrueClass)
          database.transaction(transaction_opts) do
            super(validated_params.to_h)
          end
        else
          super(validated_params.to_h)
        end
      end
    end
    prepend proxy
  end
end

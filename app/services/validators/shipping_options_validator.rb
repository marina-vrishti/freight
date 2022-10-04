# frozen_string_literal: true

module Validators
  # Validates shipping options data
  class ShippingOptionsValidator
    attr_accessor :shipping_options

    def initialize(shipping_options)
      @shipping_options = shipping_options
    end

    def call
      schema = YAML.load_file('lib/json_schemas/shipping_options.yml')

      raise 'Validation Error' unless JSON::Validator.validate(schema, shipping_options)

      true
    end
  end
end

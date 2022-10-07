# frozen_string_literal: true

module Queries
  class Result
    attr_accessor :origin_port, :destination_port, :direct

    def initialize(origin_port, destination_port, direct)
      @origin_port = origin_port
      @destination_port = destination_port
      @direct = direct
    end

    def call
      shipping_options = ShippingOptions.new.call # get options from MapReduce
      Validators::ShippingOptionsValidator.new(shipping_options).call
      normalized_options = Normalizer.new(shipping_options).call
      Queries::CheapestSailing.new(normalized_options, @origin_port, @destination_port, @direct).call
    end
  end
end

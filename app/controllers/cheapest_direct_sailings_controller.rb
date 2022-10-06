# frozen_string_literal: true

class CheapestDirectSailingsController < ApplicationController
  def index
    shipping_options = ShippingOptions.new.call
    Validators::ShippingOptionsValidator.new(shipping_options).call
    normalized_options = Normalizer.new(shipping_options).call
    cheapest = Queries::CheapestSailing.new(normalized_options, params[:origin_port], params[:destination_port],
                                            true).call
    render json: cheapest.to_json
  end

  private

  def shipping_options_params
    params.require(:shipping_options).permit(:origin_port, :destination_port)
  end
end

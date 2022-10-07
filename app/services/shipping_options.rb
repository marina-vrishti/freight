# frozen_string_literal: true

# Sends request for aggregated sails from MapReduce team
class ShippingOptions
  def initialize; end

  def call
    response =
      HTTParty.get(
        # link for the MapReduce service
        'https://60steens.club/available_sailings'
      )

    raise 'Shipping Options Not Found' unless response.success?

    JSON.parse(response.body)
  end
end

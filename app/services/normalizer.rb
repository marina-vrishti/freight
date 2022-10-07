# frozen_string_literal: true

class Normalizer
  attr_accessor :shipping_options

  def initialize(shipping_options)
    @sailings = shipping_options['sailings']
    @exchange_rates = shipping_options['exchange_rates']
    @rates = shipping_options['rates']
  end

  def call
    save_calculated_price(combined_with_rates)
  end

  def combined_with_rates
    (@sailings + @rates).group_by { |e| e['sailing_code'] }
                        .map { |_a, g| g.first.merge(g.last) }.select { |k| k['origin_port'].present? }
  end

  def save_calculated_price(sailings_merged)
    sailings_merged.map! do |sailing|
      price = rate_in_euro(sailing['rate'], sailing['rate_currency'], @exchange_rates[sailing['departure_date']])
      sailing.merge({ price: }).symbolize_keys
    end
    sailings_merged
  end

  def rate_in_euro(rate, rate_currency, exchange_rate)
    # returns price converted to euros in decimal for comparison
    ratio = exchange_rate[rate_currency.downcase].to_d
    # if exchange rate is 0, then it's `exchange_rates['eur']`, shipping cost is in euro and there's no need for exchange
    ratio == 0.to_d ? rate.to_d : rate.to_d / ratio
  end
end

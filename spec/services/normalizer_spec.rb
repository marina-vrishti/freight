require 'rails_helper'

describe Normalizer do
  let(:shipping_options) { YAML.load_file('lib/json_schemas/shipping_options_harsh_test.yml') }
  let(:sailing) do
    { arrival_date: '2022-03-01',
      departure_date: '2022-02-01',
      destination_port: 'NLRTM',
      origin_port: 'CNSHA',
      price: 0.5893e3,
      rate: '589.30',
      rate_currency: 'EUR',
      sailing_code: 'ABCD' }
  end

  it 'restructures shipping options data' do
    expect(described_class.new(shipping_options).call.first).to eq(sailing)
  end
end

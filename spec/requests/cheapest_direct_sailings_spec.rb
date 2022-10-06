require 'rails_helper'

RSpec.describe 'Cheapest Direct Sailings', type: :request do
  # Note that the result is different from the README.md result and this one is cheaper
  let(:result) do
    [{ 'arrival_date' => '2022-03-05',
       'departure_date' => '2022-01-30',
       'destination_port' => 'NLRTM',
       'origin_port' => 'CNSHA',
       'price' => '410.109534925480337583049021368288741246',
       'rate' => '456.78',
       'rate_currency' => 'USD',
       'sailing_code' => 'MNOP' }]
  end

  it 'returns cheapest direct sailing' do
    get '/cheapest_direct_sailings', params: { origin_port: 'CNSHA', destination_port: 'NLRTM' }

    expect(JSON.parse(response.body)).to eq(result)
  end
end

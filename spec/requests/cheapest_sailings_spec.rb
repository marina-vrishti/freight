require 'rails_helper'

RSpec.describe 'Cheapest Direct Sailings', type: :request do
  let(:result) do
    [{ 'arrival_date' => '2022-02-12',
       'departure_date' => '2022-01-29',
       'destination_port' => 'ESBCN',
       'origin_port' => 'CNSHA',
       'price' => '261.96',
       'rate' => '261.96',
       'rate_currency' => 'EUR',
       'sailing_code' => 'ERXQ' },
     { 'arrival_date' => '2022-02-20',
       'departure_date' => '2022-02-16',
       'destination_port' => 'NLRTM',
       'origin_port' => 'ESBCN',
       'price' => '60.930151541543285141961330778609998259',
       'rate' => '69.96',
       'rate_currency' => 'USD',
       'sailing_code' => 'ETRG' }]
  end

  it 'returns cheapest direct sailing' do
    get '/cheapest_indirect_sailings', params: { origin_port: 'CNSHA', destination_port: 'NLRTM' }

    expect(JSON.parse(response.body)).to eq(result)
  end
end

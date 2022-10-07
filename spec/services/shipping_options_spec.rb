require 'rails_helper'

describe ShippingOptions do
  let(:shipping_options) { described_class.new.call }
  it 'can fetch & parse available sailings data' do
    VCR.use_cassette('shipping_options', record: :new_episodes) do
      expect(shipping_options).to be_kind_of(Hash)
      expect(shipping_options.keys).to eq(%w[sailings rates exchange_rates])
    end
  end
end

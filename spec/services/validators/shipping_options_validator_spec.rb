require 'rails_helper'

describe Validators::ShippingOptionsValidator do
  subject { described_class.new(data).call }

  context 'when data is valid' do
    let(:data) { YAML.load_file('lib/json_schemas/shipping_options_example.yml') }

    it 'returns true' do
      expect(subject).to eq(true)
    end
  end

  context 'when settings and rates are empty' do
    let(:data) { { 'sailings': [], rates: [] } }

    it 'raises error' do
      expect { subject }.to raise_error(RuntimeError)
    end
  end

  context 'when data is an empty hash' do
    let(:data) { {} }

    it 'raises runtime error' do
      expect { subject }.to raise_error(RuntimeError)
    end
  end
end

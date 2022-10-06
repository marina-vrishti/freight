require 'rails_helper'

describe Validators::ShippingOptionsValidator do
  let(:schema_example) { YAML.load_file('lib/json_schemas/shipping_options_example.yml') }

  it 'validates shipping options data' do
    expect(described_class.new(schema_example).call).to eq(true)
    expect { described_class.new({ 'sailings': [], rates: [] }).call }.to raise_error
    expect { described_class.new({}).call }.to raise_error(RuntimeError)
  end
end

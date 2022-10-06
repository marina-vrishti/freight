require 'rails_helper'

describe Queries::CheapestSailing do
  let(:shipping_options) do
    [{ arrival_date: '2022-03-01',
       departure_date: '2022-02-01',
       destination_port: 'NLRTM',
       origin_port: 'CNSHA',
       price: 0.5893e3,
       rate: '589.30',
       rate_currency: 'EUR',
       sailing_code: 'ABCD' },
     { arrival_date: '2022-03-02',
       departure_date: '2022-02-02',
       destination_port: 'NLRTM',
       origin_port: 'CNSHA',
       price: 0.89032e3,
       rate: '890.32',
       rate_currency: 'EUR',
       sailing_code: 'EFGH' },
     { arrival_date: '2022-02-28',
       departure_date: '2022-01-31',
       destination_port: 'NLRTM',
       origin_port: 'CNSHA',
       price: 0.742782012195121951219512195121951219512e3,
       rate: '97453',
       rate_currency: 'JPY',
       sailing_code: 'IJKL' },
     { arrival_date: '2022-03-05',
       departure_date: '2022-01-30',
       destination_port: 'NLRTM',
       origin_port: 'CNSHA',
       price: 0.410109534925480337583049021368288741246e3,
       rate: '456.78',
       rate_currency: 'USD',
       sailing_code: 'MNOP' },
     { arrival_date: '2022-02-15',
       departure_date: '2022-01-29',
       destination_port: 'NLRTM',
       origin_port: 'CNSHA',
       price: 0.76196e3,
       rate: '761.96',
       rate_currency: 'EUR',
       sailing_code: 'QRST' },
     { arrival_date: '2022-02-12',
       departure_date: '2022-01-29',
       destination_port: 'ESBCN',
       origin_port: 'CNSHA',
       price: 0.26196e3,
       rate: '261.96',
       rate_currency: 'EUR',
       sailing_code: 'ERXQ' },
     { arrival_date: '2022-02-20',
       departure_date: '2022-02-16',
       destination_port: 'NLRTM',
       origin_port: 'ESBCN',
       price: 0.60930151541543285141961330778609998259e2,
       rate: '69.96',
       rate_currency: 'USD',
       sailing_code: 'ETRG' },
     { arrival_date: '2022-03-29',
       departure_date: '2022-02-15',
       destination_port: 'NLRTM',
       origin_port: 'ESBCN',
       price: 0.61795697988330575633545240790734128713e2,
       rate: '70.96',
       rate_currency: 'USD',
       sailing_code: 'ETRF' },
     { arrival_date: '2022-03-14',
       departure_date: '2022-02-16',
       destination_port: 'BRSSZ',
       origin_port: 'ESBCN',
       price: 0.383173663124891133948789409510538233758e3,
       rate: '439.96',
       rate_currency: 'USD',
       sailing_code: 'ETRB' }]
  end

  # Note that the result is different from the README.md result and this one is cheaper
  let(:direct_result) do
    [{ arrival_date: '2022-03-05',
       departure_date: '2022-01-30',
       destination_port: 'NLRTM',
       origin_port: 'CNSHA',
       price: 410.1095349254803,
       rate: '456.78',
       rate_currency: 'USD',
       sailing_code: 'MNOP' }]
  end

  let(:indirect_result) do
    [{ arrival_date: '2022-02-12',
       departure_date: '2022-01-29',
       destination_port: 'ESBCN',
       origin_port: 'CNSHA',
       price: 261.96,
       rate: '261.96',
       rate_currency: 'EUR',
       sailing_code: 'ERXQ' },
     { arrival_date: '2022-02-20',
       departure_date: '2022-02-16',
       destination_port: 'NLRTM',
       origin_port: 'ESBCN',
       price: 60.93015154154328,
       rate: '69.96',
       rate_currency: 'USD',
       sailing_code: 'ETRG' }]
  end

  it 'returns cheapest direct option' do
    expect(described_class.new(shipping_options, 'CNSHA', 'NLRTM', true).call).to eq(direct_result)
  end

  it 'returns cheapest indirect option' do
    expect(described_class.new(shipping_options, 'CNSHA', 'NLRTM', false).call).to eq(indirect_result)
  end
end

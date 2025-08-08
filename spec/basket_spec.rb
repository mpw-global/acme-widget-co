# frozen_string_literal: true
require 'spec_helper'

RSpec.describe AcmeWidgetCo::Basket do
  let(:catalogue) do
    AcmeWidgetCo::Catalogue.new(products: [
      AcmeWidgetCo::Product.new(code: 'R01', name: 'Red Widget',   price: '32.95'),
      AcmeWidgetCo::Product.new(code: 'G01', name: 'Green Widget', price: '24.95'),
      AcmeWidgetCo::Product.new(code: 'B01', name: 'Blue Widget',  price: '7.95')
    ])
  end

  let(:delivery) do
    AcmeWidgetCo::Delivery::TieredRule.new(
      bands: [
        { lt: '50', cost: '4.95' },
        { lt: '90', cost: '2.95' }
      ],
      else_cost: 0
    )
  end

  let(:offers) { [AcmeWidgetCo::Offers::SecondItemHalfPrice.new(product_code: 'R01')] }
  let(:basket) { AcmeWidgetCo::Basket.new(catalogue: catalogue, delivery_rule: delivery, offers: offers) }

  def total_for(*codes)
    b = AcmeWidgetCo::Basket.new(catalogue: catalogue, delivery_rule: delivery, offers: offers)
    codes.each { |c| b.add(c) }
    b.total
  end

  it 'B01, G01 => $37.85' do
    expect(total_for('B01', 'G01').to_f).to eq(37.85)
  end

  it 'R01, R01 => $54.37' do
    expect(total_for('R01', 'R01').to_f).to eq(54.37)
  end

  it 'R01, G01 => $60.85' do
    expect(total_for('R01', 'G01').to_f).to eq(60.85)
  end

  it 'B01, B01, R01, R01, R01 => $98.27' do
    expect(total_for('B01', 'B01', 'R01', 'R01', 'R01').to_f).to eq(98.27)
  end

  it 'raises on unknown SKU' do
    expect { basket.add('Z99') }.to raise_error(KeyError)
  end
end

require 'rails_helper'

RSpec.describe Shop, type: :model do
  existing_shop = Shop.last
  shop = existing_shop.nil? ? FactoryBot.create(:shop) : existing_shop

  # to_s

  it 'responds to to_s' do
    expect(shop.to_s).not_to be_empty
  end

  it 'responds to to_s with its name' do
    expect(shop.to_s).to eq(shop.name)
  end
end

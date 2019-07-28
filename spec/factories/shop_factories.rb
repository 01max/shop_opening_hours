FactoryBot.define do

  factory :shop do |c|
    c.name { Faker::Restaurant.name  }

    factory :shop_with_opening_slots do
      after(:create) do |shop|
        create(:opening_slot, shop: shop)
      end
    end
  end

end

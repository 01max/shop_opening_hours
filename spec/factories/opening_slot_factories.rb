FactoryBot.define do

  factory :opening_slot do |c|
    c.shop {
      if Shop.all.sample
        Shop.all.sample
      else
        FactoryBot.create(:shop)
      end
    }

    c.opening_at { Faker::Number.within(8..10)*100 }
    c.closing_at { Faker::Number.within(11..17)*100 }
    c.days_of_week { (0..6).select{ |n| [true, false].sample }.uniq }
  end

end

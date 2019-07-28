FactoryBot.define do

  factory :shop do |c|
    c.name { Faker::Restaurant.name  }
  end

end

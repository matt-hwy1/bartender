FactoryBot.define do
  factory :ingredient do
    name { Faker::Food.ingredient }
    measurement { Faker::Food.measurement }
  end
end

FactoryBot.define do
  factory :cocktail do
    name { Faker::Tea }
    category { Faker::Quote.yoda }
    container { Faker::Alphanumeric.alphanumeric(number: 10) }
    instructions { Faker::Food.description }
    image { Faker::Internet.url }

    factory :cocktail_with_ingredients do
      after(:create) do |cocktail, _context|
        create_list(:ingredient, 1, cocktail: cocktail)
        cocktail.reload
      end
    end
  end
end

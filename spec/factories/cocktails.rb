FactoryBot.define do
  factory :cocktail do
    name { Faker::Tea }
    category { Faker::String }
    container { Faker::String }
    instructions { Faker::Food.description }
    image { Faker::Internet.url }

    # ingredients
  end
end

def cocktail_with_ingredients(ingredient_count: 2)
  FactoryBot.create(:cocktail) do |cocktail|
    FactoryBot.create_list(:ingredient, ingredient_count, cocktail: cocktail)
  end
end

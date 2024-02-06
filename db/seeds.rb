# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require 'json'

# Idempotent, only updates existing records and creates new ones
# Run as often as desired
json_data = File.read(Rails.root.join('data', 'cocktail_recipes.json'))
cocktails_data = JSON.parse(json_data)

Cocktail.transaction do
  cocktails_data.each do |cocktail_data|
    cocktail = Cocktail.where(name: cocktail_data['name'])
      .first_or_create!(
        name: cocktail_data['name'],
        category: cocktail_data['category'],
        container: cocktail_data['container'],
        instructions: cocktail_data['instructions'],
        image: cocktail_data['image']
      )

    cocktail_data['ingredients'].each do |ingredient|
      cocktail.ingredients << cocktail.ingredients.where(name: ingredient['name'])
                                .first_or_create!(
                                  name: ingredient['name'],
                                  measurement: ingredient['measurement'])
    end

    puts "Cocktail #{cocktail.name} created successfully!"
  end
end

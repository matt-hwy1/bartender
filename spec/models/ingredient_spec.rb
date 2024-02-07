 require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "validations" do
    it "validates uniqueness of name" do
      cocktail = FactoryBot.create(:cocktail)
      ingredient1 = FactoryBot.create(:ingredient, name: "Lemon peel", cocktail: cocktail)
      ingredient2 = FactoryBot.build(:ingredient, name: "Lemon peel", cocktail: cocktail)
      expect(ingredient2).not_to be_valid
    end
  end
end

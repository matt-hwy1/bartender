 require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "validations" do
    let!(:cocktail) { FactoryBot.create(:cocktail, name: "Vodka Tonic") }
    let!(:ingredient) { FactoryBot.create(:ingredient, name: "Lemon peel", cocktail: cocktail) }

    it "validates uniqueness of name" do
      ingredient2 = FactoryBot.build(:ingredient, name: "Lemon peel", cocktail: cocktail)
      expect(ingredient2).not_to be_valid
    end
  end
end

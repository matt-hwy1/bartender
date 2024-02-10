 require 'rails_helper'

RSpec.describe Ingredient, type: :model do
  describe "validations" do
    let!(:cocktail) { FactoryBot.create(:cocktail, name: "Vodka Tonic") }
    let!(:ingredient) { FactoryBot.create(:ingredient, name: "Lemon peel", cocktail: cocktail) }

    it "validates presence of name" do
      ingredient2 = FactoryBot.build(:ingredient, name: "", cocktail: cocktail)
      expect(ingredient2).not_to be_valid
    end

    it "validates presence of measurement" do
      ingredient2 = FactoryBot.build(:ingredient, measurement: "", cocktail: cocktail)
      expect(ingredient2).not_to be_valid
    end

    it "validates uniqueness of name in cocktail scope" do
      ingredient2 = FactoryBot.build(:ingredient, name: "Lemon peel", cocktail: cocktail)
      expect(ingredient2).not_to be_valid
    end

    it "doesn't validate uniqueness of name outside cocktail scope" do
      cocktail2 = FactoryBot.create(:cocktail, name: "Gin & Tonic")
      ingredient2 = FactoryBot.build(:ingredient, name: "Lemon peel", cocktail: cocktail2)
      expect(ingredient2).to be_valid
    end
  end
end

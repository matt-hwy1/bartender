require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  describe "validations" do
    let!(:cocktail) { FactoryBot.create(:cocktail, name: "Vodka Tonic") }

    it "is valid with valid attributes" do
      expect(cocktail).to be_valid
    end

    it "validates presence of name" do
      cocktail.name = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence of category" do
      cocktail.category = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence of container" do
      cocktail.container = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence of instructions" do
      cocktail.instructions = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence of image" do
      cocktail.image = ""
      expect(cocktail).not_to be_valid
    end

    it "validates uniqueness of name" do
      cocktail2 = FactoryBot.build(:cocktail, name: "Vodka Tonic")
      expect(cocktail2).not_to be_valid
    end
  end

  describe "search" do
    let!(:matching_cocktails) {
      [
        FactoryBot.create(:cocktail, name: "Vodka Tonic"),
        FactoryBot.create(:cocktail, name: "Chocolate Vodka Cranberry")
      ]
    }

    let!(:non_matching_cocktails) {
      [
        FactoryBot.create(:cocktail, name: "Gin & Tonic"),
        FactoryBot.create(:cocktail, name: "Rum Punch")
      ]
    }

    it "returns records matching the search string" do
      expect(Cocktail.search("vod").to_a).to match_array(matching_cocktails)
    end
  end
end

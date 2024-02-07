require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      expect(FactoryBot.create(:cocktail)).to be_valid
    end

    it "validates presence of name" do
      cocktail = FactoryBot.create(:cocktail)
      cocktail.name = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence of category" do
      cocktail = FactoryBot.create(:cocktail)
      cocktail.category = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence of container" do
      cocktail = FactoryBot.create(:cocktail)
      cocktail.container = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence of instructions" do
      cocktail = FactoryBot.create(:cocktail)
      cocktail.instructions = ""
      expect(cocktail).not_to be_valid
    end

    it "validates presence ofimage" do
      cocktail = FactoryBot.create(:cocktail)
      cocktail.image = ""
      expect(cocktail).not_to be_valid
    end
  end
end

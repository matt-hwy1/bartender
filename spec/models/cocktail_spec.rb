# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  describe 'validations' do
    let!(:cocktail) { FactoryBot.create(:cocktail, name: 'Vodka Tonic') }

    it 'is valid with valid attributes' do
      expect(cocktail).to be_valid
    end

    it 'validates presence of name' do
      cocktail.name = ''
      expect(cocktail).not_to be_valid
    end

    it 'validates presence of category' do
      cocktail.category = ''
      expect(cocktail).not_to be_valid
    end

    it 'validates presence of container' do
      cocktail.container = ''
      expect(cocktail).not_to be_valid
    end

    it 'validates presence of instructions' do
      cocktail.instructions = ''
      expect(cocktail).not_to be_valid
    end

    it 'validates presence of image' do
      cocktail.image = ''
      expect(cocktail).not_to be_valid
    end

    it 'validates uniqueness of name' do
      cocktail2 = FactoryBot.build(:cocktail, name: 'Vodka Tonic')
      expect(cocktail2).not_to be_valid
    end
  end

  describe 'search' do
    let!(:matching_cocktails) do
      [
        FactoryBot.create(:cocktail, name: 'Vodka Tonic'),
        FactoryBot.create(:cocktail, name: 'Chocolate Vodka Cranberry')
      ]
    end

    let!(:non_matching_cocktails) do
      [
        FactoryBot.create(:cocktail, name: 'Gin & Tonic'),
        FactoryBot.create(:cocktail, name: 'Rum Punch')
      ]
    end

    it 'returns records matching the search string' do
      expect(Cocktail.search('vod').to_a).to match_array(matching_cocktails)
    end

    it 'returns an empty array if no matching records are found' do
      expect(Cocktail.search('XYZ').to_a).to eq []
    end

    it 'returns an empty array if no query string is passed' do
      expect(Cocktail.search(nil).to_a).to eq []
    end
  end
end

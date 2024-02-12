# frozen_string_literal: true

class Ingredient < ApplicationRecord
  belongs_to :cocktail

  validates :name, :measurement, presence: true
  validates :name, uniqueness: { scope: :cocktail }
end

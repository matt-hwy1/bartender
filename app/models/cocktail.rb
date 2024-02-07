class Cocktail < ApplicationRecord
  has_many :ingredients, dependent: :destroy

  def as_json(options = nil)
    super({ only: [:id, :name, :category, :container, :instructions, :image],
            include: { ingredients: { only: [:name, :measurement] } } }.merge(options || {}))
  end
end

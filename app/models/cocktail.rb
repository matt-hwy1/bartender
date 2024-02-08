class Cocktail < ApplicationRecord
  has_many :ingredients, dependent: :destroy

  validates :name, :category, :container, :instructions, :image, presence: true
  validates :name, uniqueness: true

  scope :search, ->(query) { includes(:ingredients).where("name LIKE ?", "%#{query}%") }

  def as_json(options = nil)
    super({ only: [:id, :name, :category, :container, :instructions, :image],
            include: { ingredients: { only: [:name, :measurement] } } }.merge(options || {}))
  end
end

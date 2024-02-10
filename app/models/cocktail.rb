class Cocktail < ApplicationRecord
  OFFSET = 0
  PAGE_SIZE = 20

  has_many :ingredients, dependent: :destroy

  validates :name, :category, :container, :instructions, :image, presence: true
  validates :name, uniqueness: true

  scope :search, ->(query, offset = 0, limit = 100) do
    if query.present?
      includes(:ingredients).where("name ILIKE ?", "%#{query}%")
                            .order(name: :asc)
                            .offset(offset)
                            .limit(limit)
    else
      []
    end
  end

  # Improvement here would be to replace this method with serialization via JBuilder or ActiveModel Serialization
  def as_json(options = nil)
    super({ only: [:id, :name, :category, :container, :instructions, :image],
            include: { ingredients: { only: [:name, :measurement] } } }.merge(options || {}))
  end
end

class Cocktail < ApplicationRecord
  OFFSET = 0
  PAGE_SIZE = 20

  has_many :ingredients, dependent: :destroy

  validates :name, :category, :container, :instructions, :image, presence: true
  validates :name, uniqueness: true

  scope :detail, ->(id) { includes(:ingredients).where(id: id) }

  scope :search, ->(query) do
    if query.present?
      where("name ILIKE ?", "%#{query}%").order(name: :asc)
    else
      none
    end
  end

  scope :with_ingredients, -> { includes(:ingredients) }

  scope :paginate, ->(offset, limit) { offset(offset).limit(limit) }

  # Improvement here would be to replace this method with serialization via JBuilder or ActiveModel Serialization
  def as_json(options = nil)
    super({ only: [:id, :name, :category, :container, :instructions, :image],
            include: { ingredients: { only: [:name, :measurement] } } }.merge(options || {}))
  end
end

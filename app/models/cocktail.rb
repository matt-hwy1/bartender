# frozen_string_literal: true

class Cocktail < ApplicationRecord
  PAGE = 1
  PAGE_SIZE = 5

  has_many :ingredients, dependent: :destroy

  validates :name, :category, :container, :instructions, :image, presence: true
  validates :name, uniqueness: true

  scope :detail, ->(id) { includes(:ingredients).where(id:) }

  scope :search, lambda { |query|
    if query.present?
      # PostgreSQL-specific case insensitive LIKE operator
      where('name ILIKE ?', "%#{query}%").order(name: :asc)
    else
      none
    end
  }

  scope :with_ingredients, -> { includes(:ingredients) }

  scope :paginate, lambda { |page, page_size|
    page_number = page.to_i
    page_size_number = page_size.to_i

    if page_number < 1 || page_size_number < 1
      none
    else
      offset = (page_number - 1) * page_size_number.to_i
      offset(offset).limit(page_size_number)
    end
  }

  # Improvement here would be to replace this method with serialization via JBuilder or ActiveModel Serialization
  def as_json(options = nil)
    super({ only: %i[id name category container instructions image],
            include: { ingredients: { only: %i[name measurement] } } }.merge(options || {}))
  end
end

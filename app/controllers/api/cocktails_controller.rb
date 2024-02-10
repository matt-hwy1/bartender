class Api::CocktailsController < ApplicationController
  # Clear improvements here would be:
  # Authentication of the API, although the requirements stated that it was a public API
  # Factor out the JSON generation into a JSON serialization library like JBuilder
  #   or ActiveModel serializers
  # Implement full-text searching in the database and queries if it grows in size

  def index
    render json: { drinks: Cocktail.search(query, offset, limit) }
  end

  def show
    # Using where here instead of find in order to return an empty array in case the record is not found
    render json: { drinks: Cocktail.includes(:ingredients).where(id: params[:id]) }
  end

  private

  def query
    params[:query]
  end

  def offset
    params[:offset] || Cocktail::OFFSET
  end

  def limit
    params[:limit] || Cocktail::PAGE_SIZE
  end
end

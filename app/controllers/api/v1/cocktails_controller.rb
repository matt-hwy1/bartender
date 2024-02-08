class Api::V1::CocktailsController < ApplicationController
  # Clear improvements here would be:
  # Authentication of the API
  # Factor out the JSON generation into a JSON serialization library like JBuilder
  #   or ActiveModel serializers
  # Implement full-text searching in the database and queries if it grows in size

  # TODO: Add pagination

  def index
    if params[:query].present? && params[:query].length >= 3
      render json: { cocktails: Cocktail.search(params[:query]) }
    else
      render json: []
    end
  end

  def show
    render json: { cocktail: Cocktail.includes(:ingredients).find(params[:id]) }
  end
end

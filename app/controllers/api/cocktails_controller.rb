module Api
  class CocktailsController < ApplicationController
    # Clear improvements here would be:
    # Authentication of the API, although the requirements stated that it was a public API
    # Factor out the JSON generation into a JSON serialization library like JBuilder
    #   or ActiveModel serializers
    # Implement full-text searching in the database and queries if it grows in size

    def index
      render json: { drinks: Cocktail.search(query).with_ingredients.paginate(offset, limit) }
    end

    def show
      # Using where here instead of find in order to return an empty array in case the record is not found
      render json: { drinks: Cocktail.with_ingredients.detail(params[:id]) }
    end

    def count
      render json: { count: Cocktail.search(query).count }
    end

    private

    def query
      params[:query]
    end

    def offset
      params[:page] || Cocktail::PAGE
    end

    def limit
      params[:page_size] || Cocktail::PAGE_SIZE
    end
  end
end

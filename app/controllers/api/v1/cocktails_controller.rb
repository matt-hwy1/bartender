class Api::V1::CocktailsController < ApplicationController
  def index
    if params[:q].present? && params[:q].length >= 3
      render json: { cocktails: Cocktail.includes(:ingredients).where("name LIKE ?", "%#{params[:q]}%") }
    else
      render json: { error: "The cocktail search parameter must be at least 3 characters long"}
    end
  end

  def show
    render json: { cocktail: Cocktail.includes(:ingredients).find(params[:id]).to_api_json }
  end
end

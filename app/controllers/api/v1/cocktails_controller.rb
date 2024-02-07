class Api::V1::CocktailsController < ApplicationController
  def index
    if params[:q].present? && params[:q].length >= 3
      render json: Cocktail.includes(:ingredients).where("name LIKE ?", "%#{params[:q]}%")
    else
      render json: []
    end
  end

  def show
    render json: Cocktail.includes(:ingredients).find(params[:id])
  end
end

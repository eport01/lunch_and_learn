class Api::V1::RecipesController < ApplicationController 
  def index 
    if params[:country] != "" 
      render json: RecipesSerializer.new(RecipesFacade.recipes(params[:country]))
    elsif params[:country] == "" 
      render json: RecipesSerializer.new(RecipesFacade.recipes(CountryFacade.country.sample.name))
    end
  end
end
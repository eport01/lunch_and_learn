class Api::V1::RecipesController < ApplicationController 
  def index 
    if params[:country] == "" 
      country = CountryFacade.country.sample.name 
    else 
      country = params[:country]
    end
    render json: RecipesSerializer.new(RecipesFacade.recipes(country))
  end
end
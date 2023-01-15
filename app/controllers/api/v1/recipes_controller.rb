class Api::V1::RecipesController < ApplicationController 
  def index 
    if params[:country] == "" 
      country = CountryFacade.random_country.sample 
      render json: RecipesSerializer.new(RecipesFacade.recipes(country.name))
    else 
      country = CountryFacade.select_country(params[:country])
      if country != nil 
        render json: RecipesSerializer.new(RecipesFacade.recipes(country.name))
      else
        render json: {data: []}
      end
    end
  end
end
class Api::V1::RecipesController < ApplicationController 
  before_action :find_user 

  def index 
    if @user != nil && params[:api_key]
      if params[:country] == "" 
        country = CountryFacade.random_country.sample 
        render json: RecipesSerializer.new(RecipesFacade.recipes(country.name))
      else 
        country = CountryFacade.select_country(params[:country])
        if country != nil 
          recipes_cache = Rails.cache.read(['recipes_data'])
          if recipes_cache == nil 
            recipes_cache = RecipesFacade.recipes(country.name)
            Rails.cache.write(['recipes_data'], recipes_cache, expires_in: 5.minutes)
            render json: RecipesSerializer.new(recipes_cache)
          else 
            render json: RecipesSerializer.new(recipes_cache)

          end
          # render json: RecipesSerializer.new(RecipesFacade.recipes(country.name))
        else
          render json: {data: []}
        end
      end
    else
      render json: {error: "Please create an account to receive an API key"}
    end
  end

  private 
  def find_user 
    @user = User.find_by(api_key: params[:api_key])
  end
end
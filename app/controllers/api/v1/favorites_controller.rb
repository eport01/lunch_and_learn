class Api::V1::FavoritesController < ApplicationController 
  def create 
    user = User.find_by(api_key: params[:api_key])
    if user != nil  
      user.favorites.create!(fave_params)
      render json: {success: "Favorite added successfully"}, status: 201
    else
      render json: {error: "No user with that api key exists"}, status: 404

    end

  end

  def index 
    user = User.find_by(api_key: params[:api_key])
    render json: FavoriteSerializer.new(user.favorites)
  end

  private 
  def fave_params 
    params.permit(:country, :recipe_link, :recipe_title)
  end
end
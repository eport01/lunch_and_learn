class Api::V1::FavoritesController < ApplicationController 
  def create 
    user = User.find_by(api_key: params[:api_key])
    user.favorites.create!(fave_params)
    render json: {success: "Favorite added successfully"}, status: 201
  end

  private 
  def fave_params 
    params.permit(:country, :recipe_link, :recipe_title)
  end
end
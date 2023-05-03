class Api::V1::FavoritesController < ApplicationController 
  before_action :find_user 
  def create 
    # user = User.find_by(api_key: params[:api_key])
    if @user != nil  
      @user.favorites.create!(fave_params)
      render json: {success: "Favorite added successfully"}, status: 201
    else
      render json: {error: "No user with that api key exists"}, status: 404

    end

  end

  def index 
    # user = User.find_by(api_key: params[:api_key])
    if @user != nil && params[:api_key]
      favorites_cache = Rails.cache.read(['favorite_data', @user])
      if favorites_cache == nil 
        favorites_cache = @user.favorites 
        Rails.cache.write(['favorite_data', @user], favorites_cache, expires_in: 5.minutes)
        render json: FavoriteSerializer.new(favorites_cache)

      else
        render json: FavoriteSerializer.new(favorites_cache)

      end
    else 
      render json: {error: "No user with that api key exists"}, status: 404
    end
  end

  def destroy 
    # user = User.find_by(api_key: params[:api_key])
    if @user.favorites.where(id: params[:favorite_id]) != []
      @user.favorites.delete(params[:favorite_id])
      render json: {message: "The recipe was successfully deleted from your favorites"}
    else  
      render json: {error: "No favorite recipe exists with that id"}, status: 404
    end
  end



  private 
  def fave_params 
    params.permit(:country, :recipe_link, :recipe_title)
  end

  def find_user 
    @user = User.find_by(api_key: params[:api_key])
  end
end
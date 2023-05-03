class Api::V1::LearningResourcesController < ApplicationController 
  before_action :find_user
  def index 
    if params[:api_key] && @user != nil 
      resources_cache = Rails.cache.read(['resources_data'])

      if resources_cache == nil || resources_cache.country != params[:country]
        resources_cache = LearningResourcesFacade.resources(params[:country])
        Rails.cache.write(['resources_data'], resources_cache, expires_in: 5.minutes)
        render json: LearningResourcesSerializer.new(resources_cache)
      else
        render json: LearningResourcesSerializer.new(resources_cache)
      end


      # render json: LearningResourcesSerializer.new(LearningResourcesFacade.resources(params[:country]))
    else 
      render json: {error: "Country cannot be blank"}
    end
  end


  private 
  def find_user 
    @user = User.find_by(api_key: params[:api_key])
  end
end
class Api::V1::LearningResourcesController < ApplicationController 
  def index 
    render json: LearningResourcesSerializer.new(LearningResourcesFacade.resources(params[:country]))
  end
end
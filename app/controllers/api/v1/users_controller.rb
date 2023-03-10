class Api::V1::UsersController < ApplicationController 
  def create 
    user = User.new(user_params)
    if user.valid? 
      user.save 
      session[:user_id] = user.id
      user.update(api_key: SecureRandom.hex)
      render json: UserSerializer.new(User.last), status: 201
    else
      render json: {error: "This user already exists, please login"}, status: 404

    end
  end

  # def login 
  #   user = User.find_by(email: params[:email])
  # end

  # def logout 

  # end

  private 
  def user_params
    params.permit(:name, :email, :password, :api_key)
  end
end
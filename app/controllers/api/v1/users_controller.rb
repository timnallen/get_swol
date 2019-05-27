class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.new(user_params)
    if user.save
      render json: {
        message: "You have successfully created a user!",
        user: UserSerializer.new(user)
      }, status: 201
    else
      four_oh_four
    end
  end

  private

  def user_params
    params.permit(:name)
  end
end

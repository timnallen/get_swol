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
      determine_error(user)
    end
  end

  private

  def determine_error(user)
    errors = user.errors.details
    if errors.has_key?(:email) && errors[:email].first[:error] == :taken
      render json: {message: "That email is already taken"}, status: 409
    else
      four_oh_four
    end
  end

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end

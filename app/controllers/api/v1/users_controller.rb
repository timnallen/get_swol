class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    request_body = JSON.parse(request.body.read, symbolize_names: true)
    user = User.find_by(email: request_body[:email])
    if user && user.authenticate(request_body[:password])
      render json: UserSerializer.new(user)
    else
      render json: {message: "Unauthorized. Incorrect email and/or password"}, status: 401
    end
  end

  def create
    user = User.new(user_params)
    if user.save
      generate_api_key(user)
      render json: {
        message: "You have successfully created a user!",
        user: UserSerializer.new(user)
      }, status: 201
    else
      determine_error(user)
    end
  end

  private

  def generate_api_key(user)
    user.update(api_key: rand(36**36).to_s(36))
  end

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

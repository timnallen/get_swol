class Api::V1::UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    render json: { user: user }
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: {"message": "You have successfully created a user!"}, status: 201
    else
      four_oh_four
    end
  end

  private

  def user_params
    params.permit(:name)
  end
end

class ApplicationController < ActionController::Base
  def four_oh_four
    render json: {error: 'not-found'}, status: 404
  end

  def unauthorized
    render json: {error: 'unauthorized'}, status: 401
  end

  def auth_params
    {id: params[:user_id], api_key: params[:api_key]}
  end

  def authorized?(user_params)
    User.find_by(user_params)
  end
end

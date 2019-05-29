class ApplicationController < ActionController::Base
  def four_oh_four
    render json: {error: 'not-found'}, status: 404
  end

  def unauthorized
    render json: {error: 'unauthorized'}, status: 401
  end
end

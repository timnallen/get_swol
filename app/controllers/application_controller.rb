class ApplicationController < ActionController::Base
  def four_oh_four
    render json: {error: 'not-found'}, status: 404
  end
end

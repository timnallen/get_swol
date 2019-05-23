class ApplicationController < ActionController::Base
  def four_oh_four
    render file: 'errors/not_found', status: 404
  end
end

class Api::V1::MyRoutinesController < ApplicationController
  def index
    render json: RoutineSerializer.new(routine_finder(params))
  end

  private

  def routine_finder(params)
    urs = UserRoutine.where(user_id: params[:id], date: params[:date]).pluck(:id)
    Routine.joins(:user_routines).where("user_routines.id in (?)", urs)
  end
end

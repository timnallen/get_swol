class Api::V1::MyRoutinesController < ApplicationController
  def index
    render json: RoutineSerializer.new(routine_finder(params))
  end

  def create
    routine = Routine.find(params[:routine_id])
    user_routine = UserRoutine.new(user_routine_params)
    if user_routine.save
      render json: {message: "You have successfully scheduled #{routine.name} on #{user_routine.date}!"}
    else
      four_oh_four
    end
  end

  private

  def user_routine_params
    params.permit(:date, :user_id, :routine_id)
  end

  def routine_finder(params)
    urs = UserRoutine.where(user_id: params[:id], date: params[:date]).pluck(:id)
    Routine.joins(:user_routines).where("user_routines.id in (?)", urs)
  end
end

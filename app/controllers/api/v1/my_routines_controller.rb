class Api::V1::MyRoutinesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    user = authorized?(auth_params)
    if user
      render json: RoutineSerializer.new(routine_finder(params, user))
    else
      unauthorized
    end
  end

  def create
    routine = Routine.find(params[:routine_id]) if params[:routine_id]
    user_routine = UserRoutine.new(user_routine_params) if routine
    if user_routine&.save
      render json: {
        message: "You have successfully scheduled #{routine.name} on #{user_routine.date}!",
        routine: RoutineSerializer.new(Routine.includes(:exercises, :exercise_routines))
      }
    else
      four_oh_four
    end
  end

  def destroy
    user_routine = UserRoutine.find_by(
      routine_id: params[:routine_id],
      user_id: params[:user_id],
      date: params[:date]
    )
    if user_routine
      user_routine.destroy
    else
      four_oh_four
    end
  end

  private

  def auth_params
    params.permit(:id, :api_key)
  end

  def user_routine_params
    params.permit(:date, :user_id, :routine_id)
  end

  def authorized?(user_params)
    User.find_by(user_params)
  end

  def routine_finder(params, user)
    urs = UserRoutine.where(user_id: user.id, date: params[:date]).pluck(:id)
    Routine.joins(:user_routines).where("user_routines.id in (?)", urs)
  end
end

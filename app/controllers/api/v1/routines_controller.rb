class Api::V1::RoutinesController < ApplicationController
  def index
    render json: RoutineSerializer.new(Routine.includes(:exercises, :exercise_routines))
  end

  def show
    render json: RoutineSerializer.new(Routine.find(params[:id]))
  end

  def create
    user = User.find(params[:user_id]) if params[:user_id]
    routine = Routine.new(routine_params)
    if user && routine.save
      render json: {message: "You have successfully created a workout sequence!"}, status: 201
    else
      four_oh_four
    end
  end

  private

  def routine_params
    params.permit(:name)
  end
end

class Api::V1::RoutinesController < ApplicationController
  def index
    render json: RoutineSerializer.new(Routine.includes(:exercises, :exercise_routines))
  end

  def show
    render json: RoutineSerializer.new(Routine.find(params[:id]))
  end
end

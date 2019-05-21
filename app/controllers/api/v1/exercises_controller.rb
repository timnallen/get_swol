class Api::V1::ExercisesController < ApplicationController
  def index
    render json: ExerciseSerializer.new(Exercise.all)
  end

  def show
    render json: ExerciseSerializer.new(Exercise.find(params[:id]))
  end
end

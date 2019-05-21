class Api::V1::ExercisesController < ApplicationController
  def index
    render json: ExerciseSerializer.new(Exercise.all)
  end
end

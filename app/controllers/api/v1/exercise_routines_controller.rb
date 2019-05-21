class Api::V1::ExerciseRoutinesController < ApplicationController
  def index
    render json: ExerciseRoutineSerializer.new(ExerciseRoutine.all)
  end
end

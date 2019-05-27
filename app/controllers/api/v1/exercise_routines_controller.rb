class Api::V1::ExerciseRoutinesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: ExerciseRoutineSerializer.new(ExerciseRoutine.all)
  end

  def create
    er = ExerciseRoutine.new(exercise_routine_params)
    if er.save
      ex = er.exercise
      rou = er.routine
      render json: {
        message: "You have added #{ex.name} to #{rou.name}!",
        routine: RoutineSerializer.new(rou)
      }, status: 201
    else
      four_oh_four
    end
  end

  def destroy
    ExerciseRoutine.destroy(params[:id])
  end

  private

  def exercise_routine_params
    params.permit(:exercise_id, :routine_id, :reps, :sets, :duration, :weight)
  end
end

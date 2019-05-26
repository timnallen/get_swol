class Api::V1::ExerciseRoutinesController < ApplicationController
  def index
    render json: ExerciseRoutineSerializer.new(ExerciseRoutine.all)
  end

  def create
    er = ExerciseRoutine.new(exercise_routine_params)
    if er.save
      ex = er.exercise
      rou = er.routine
      render json: {id: er.id, message: "You have added #{ex.name} to #{rou.name}!"}, status: 201
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

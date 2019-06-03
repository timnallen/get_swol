class Api::V1::RoutinesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: RoutineSerializer.new(Routine.includes(:exercises, :exercise_routines))
  end

  def show
    render json: RoutineSerializer.new(Routine.includes(:exercises, :exercise_routines).find(params[:id]))
  end

  def create
    user = authorized?(auth_params)
    if user
      routine_creation
    else
      unauthorized
    end
  end

  def update
    routine = Routine.find(params[:id])
    if routine_params[:name] && routine.update(routine_params)
      render json: RoutineSerializer.new(routine)
    else
      four_oh_four
    end
  end

  def destroy
    Routine.destroy(params[:id])
  end

  private

  def routine_creation
    routine = Routine.new(routine_params)
    if routine.save
      add_exercises(params[:exercises], routine) if params[:exercises]
      render json: {
        message: "You have successfully created a routine!",
        routine: RoutineSerializer.new(routine)
      }, status: 201
    else
      four_oh_four
    end
  end

  def add_exercises(exercises, routine)
    exercises.each do |exercise_id|
      ExerciseRoutine.create(exercise_id: exercise_id, routine: routine)
    end
  end

  def routine_params
    params.permit(:name, :exercises)
  end
end

class Api::V1::RoutinesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
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
      exercises = add_exercises(params[:exercises], routine) if params[:exercises]
      render json: {
        message: "You have successfully created a routine!",
        id: routine.id,
        exercises: exercises
      }, status: 201
    else
      four_oh_four
    end
  end

  def update
    routine = Routine.find(params[:id])
    if routine_params[:name] && routine.update(routine_params)
      render json: {id: routine.id, name: routine.name}
    else
      four_oh_four
    end
  end

  def destroy
    Routine.destroy(params[:id])
  end

  private

  def add_exercises(exercises, routine)
    exercises.map do |exercise_id|
      er = ExerciseRoutine.create(exercise_id: exercise_id, routine: routine)
      er.exercise
    end
  end

  def routine_params
    params.permit(:name, :exercises)
  end
end

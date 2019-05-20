require 'rails_helper'

RSpec.describe ExerciseRoutine, type: :model do
  before :each do
    exercise = Exercise.create(name: 'Squats')
    routine = Routine.create(name: 'Leg Day')
    @exercise_routine = ExerciseRoutine.create(exercise: exercise, routine: routine, reps: 12, sets: 4)
  end

  it 'exists' do
    expect(@exercise_routine).to be_a(ExerciseRoutine)
  end

  it 'has attributes' do
    expect(@exercise_routine.reps).to eq(12)
    expect(@exercise_routine.sets).to eq(4)
  end

  describe 'validations' do
    it { should validate_presence_of :routine}
    it { should validate_presence_of :exercise}
  end

  describe 'relationships' do
    it { should belong_to :exercise}
    it { should belong_to :routine}
  end
end

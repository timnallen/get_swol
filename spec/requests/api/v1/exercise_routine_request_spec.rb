require 'rails_helper'

describe 'Exercise Routines API' do
  describe 'Endpoints' do
    it 'can get a list of exercise routines' do
      ex1 = Exercise.create(name: 'Squats', category: 'legs', muscle: 'Quadriceps', equipment_required: 'none')
      ex2 = Exercise.create(name: 'Hammy Lifts', category: 'legs', muscle: 'Hamstrings', equipment_required: 'That machine')
      ex3 = Exercise.create(name: 'Jogging', category: 'legs', muscle: 'Legs', equipment_required: 'none')
      r1 = Routine.create(name: 'Leg Day')
      ExerciseRoutine.create(exercise: ex1, routine: r1, reps: 12, sets: 4)
      ExerciseRoutine.create(exercise: ex2, routine: r1, reps: 10, sets: 3, weight: 25)
      ExerciseRoutine.create(exercise: ex3, routine: r1, duration: 30)

      get '/api/v1/exercise_routines'

      expect(response).to be_successful
      ers = JSON.parse(response.body, symbolize_names: true)
      expect(ers[:data].count).to eq(3)
      expect(ers[:data][0].keys).to eq([:id, :type, :attributes])
      expect(ers[:data][0][:type]).to eq('exercise_routine')
      expect(ers[:data][0][:attributes].keys).to include(:exercise_id)
      expect(ers[:data][0][:attributes].keys).to include(:routine_id)
      expect(ers[:data][0][:attributes].keys).to include(:reps)
      expect(ers[:data][0][:attributes].keys).to include(:sets)
      expect(ers[:data][1][:attributes].keys).to include(:weight)
      expect(ers[:data][2][:attributes].keys).to include(:duration)
      expect(ers[:data][2][:attributes][:duration]).to eq(30)
      expect(ers[:data][1][:attributes][:weight]).to eq(25)
      expect(ers[:data][0][:attributes][:reps]).to eq(12)
      expect(ers[:data][0][:attributes][:sets]).to eq(4)
      expect(ers[:data][1][:attributes][:sets]).to eq(3)
    end
  end
end

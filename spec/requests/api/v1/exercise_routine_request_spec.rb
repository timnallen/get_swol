require 'rails_helper'

describe 'Exercise Routines API' do
  describe 'Endpoints' do
    before :each do
      ex1 = Exercise.create(name: 'Squats', category: 'legs', muscle: 'Quadriceps', equipment_required: 'none')
      ex2 = Exercise.create(name: 'Hammy Lifts', category: 'legs', muscle: 'Hamstrings', equipment_required: 'That machine')
      @ex3 = Exercise.create(name: 'Jogging', category: 'legs', muscle: 'Legs', equipment_required: 'none')
      @r1 = Routine.create(name: 'Leg Day')
      ExerciseRoutine.create(exercise: ex1, routine: @r1, reps: 12, sets: 4)
      ExerciseRoutine.create(exercise: ex2, routine: @r1, reps: 10, sets: 3, weight: 25)
      @er = ExerciseRoutine.create(exercise: @ex3, routine: @r1, duration: 30)
    end

    it 'can get a list of exercise routines' do
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

    it 'can add an exercise to a routine' do
      ex = Exercise.create(name: 'Scissor Kicks', equipment_required: 'none', muscle: 'legs', category: 'legs')
      body = {
        exercise_id: ex.id,
        routine_id: @r1.id
      }

      post '/api/v1/exercise_routines', params: body

      expect(response.status).to eq(201)
      res = JSON.parse(response.body, symbolize_names: true)
      expect(res[:routine][:data].keys).to include(:id)
      expect(res[:message]).to eq("You have added #{ex.name} to #{@r1.name}!")
    end

    it 'cant add an exercise to a routine without a body' do
      post '/api/v1/exercise_routines'

      expect(response.status).to eq(404)
    end

    it 'can remove an exercise from a routine' do
      delete "/api/v1/exercise_routines/#{@er.id}"

      expect(response.status).to eq(204)

      expect(@r1.exercises.count).to eq(2)
    end
  end
end

require 'rails_helper'

describe 'Routines API' do
  describe 'Endpoints' do
    before :each do
      @routine = Routine.create(name: 'Cardio Day')
      @leg_day = Routine.create(name: 'Leg Day')
      single_leg_press = Exercise.create(name: 'Single-Leg Press', equipment_required: 'legs', muscle: 'legs', category: 'This')
      ExerciseRoutine.create(routine: @leg_day, exercise: single_leg_press, sets: 4, reps: 12)
      Routine.create(name: 'Arm Day')
    end

    it 'can get a list of routines' do
      get '/api/v1/routines'

      expect(response).to be_successful
      routines = JSON.parse(response.body, symbolize_names: true)
      expect(routines[:data].count).to eq(3)
      expect(routines[:data]).to be_a(Array)
      expect(routines[:data][0]).to be_a(Hash)
      expect(routines[:data][0].keys).to include(:id)
      expect(routines[:data][0].keys).to include(:type)
      expect(routines[:data][0][:type]).to eq('routine')
      expect(routines[:data][0][:attributes][:name]).to eq('Cardio Day')
    end

    it 'can get a single routine' do
      get "/api/v1/routines/#{@leg_day.id}"

      expect(response).to be_successful
      routine = JSON.parse(response.body, symbolize_names: true)
      expect(routine[:data]).to be_a(Hash)
      expect(routine[:data][:id]).to eq(@leg_day.id.to_s)
      expect(routine[:data][:type]).to eq('routine')
      expect(routine[:data][:attributes][:name]).to eq('Leg Day')
      expect(routine[:data][:attributes][:exercises]).to be_a(Array)
      expect(routine[:data][:attributes][:exercises][0][:name]).to eq('Single-Leg Press')
    end
  end
end

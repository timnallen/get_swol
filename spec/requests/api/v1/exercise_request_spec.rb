require 'rails_helper'

describe 'Exercises API' do
  describe 'Endpoints' do
    before :each do
      Exercise.create(name: 'Squats', category: 'legs', equipment_required: 'none')
      Exercise.create(name: 'Bicep Curls', category: 'arms', equipment_required: 'Dumb-bells')
      Exercise.create(name: 'Jogging', category: 'legs', equipment_required: 'none')
    end

    it 'can get a list of exercises' do
      get '/api/v1/exercises'

      expect(response).to be_successful
      exercises = JSON.parse(response.body, symbolize_names: true)
      expect(exercises[:data].count).to eq(3)
      expect(exercises[:data]).to be_a(Array)
      expect(exercises[:data][0]).to be_a(Hash)
      expect(exercises[:data][0].keys).to include(:id)
      expect(exercises[:data][0].keys).to include(:type)
      expect(exercises[:data][0][:type]).to eq('exercise')
      expect(exercises[:data][0][:attributes][:name]).to eq('Squats')
      expect(exercises[:data][0][:attributes][:category]).to eq('legs')
      expect(exercises[:data][0][:attributes][:equipment_required]).to eq('none')
    end

    it 'can get a single exercise' do
      get '/api/v1/exercises/1'

      expect(response).to be_successful
      exercise = JSON.parse(response.body, symbolize_names: true)
      expect(exercise[:data]).to be_a(Hash)
      expect(exercise[:data][:id]).to eq(1)
      expect(exercise[:data][:type]).to eq('exercise')
      expect(exercise[:data][:attributes][:name]).to eq('Squats')
      expect(exercise[:data][:attributes][:category]).to eq('legs')
      expect(exercise[:data][:attributes][:equipment_required]).to eq('none')
    end
  end
end

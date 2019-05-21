require 'rails_helper'

describe 'Exercises API' do
  describe 'Endpoints' do
    it 'can get a list of exercises' do
      Exercise.create(name: 'Squats', category: 'legs', equipment_required: 'none')
      Exercise.create(name: 'Bicep Curls', category: 'arms', equipment_required: 'Dumb-bells')
      Exercise.create(name: 'Jogging', category: 'legs', equipment_required: 'none')

      get '/api/v1/exercises'

      expect(response).to be_successful
      exercises = JSON.parse(response.body, symbolize_names: true)
      expect(exercises.count).to eq(3)
      expect(exercises).to be_a(Array)
      expect(exercises[0]).to be_a(Hash)
      expect(exercises[0].keys).to include(:id)
      expect(exercises[0][:name]).to eq('Squats')
      expect(exercises[0][:category]).to eq('legs')
      expect(exercises[0][:equipment_required]).to eq('none')
    end
  end
end

require 'rails_helper'

describe 'Routines API' do
  describe 'Endpoints' do
    before :each do
      @routine = Routine.create(name: 'Cardio Day')
      Routine.create(name: 'Leg Day')
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
      get "/api/v1/routines/#{@routine.id}"

      expect(response).to be_successful
      routine = JSON.parse(response.body, symbolize_names: true)
      expect(routine[:data]).to be_a(Hash)
      expect(routine[:data][:id]).to eq(@routine.id.to_s)
      expect(routine[:data][:type]).to eq('routine')
      expect(routine[:data][:attributes][:name]).to eq('Cardio Day')
    end
  end
end

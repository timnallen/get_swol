require 'rails_helper'

describe 'Routines API' do
  describe 'Endpoints' do
    before :each do
      @routine = Routine.create(name: 'Cardio Day')
      @leg_day = Routine.create(name: 'Leg Day')
      @single_leg_press = Exercise.create(name: 'Single-Leg Press', equipment_required: 'legs', muscle: 'legs', category: 'This')
      ExerciseRoutine.create(routine: @leg_day, exercise: @single_leg_press, sets: 4, reps: 12)
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

    it 'allows user to create a routine' do
      user = User.create(name: 'John')

      body = {name: 'Abs Day', exercises: [@single_leg_press.id]}

      post "/api/v1/routines?user_id=#{user.id}", params: body

      expect(response.status).to eq(201)
      routine = JSON.parse(response.body, symbolize_names: true)
      expect(routine[:message]).to eq("You have successfully created a routine!")
      expect(routine[:routine][:data].keys).to include(:id)
      expect(routine[:routine][:data][:attributes][:exercises]).to be_a(Array)
      expect(routine[:routine][:data][:attributes][:exercises][0].keys).to include(:id, :name, :muscle)
    end

    it 'does not allow creation without a routine and a user id' do
      body = {name: 'Abs Day'}

      post "/api/v1/routines", params: body

      expect(response.status).to eq(404)
    end

    it 'can update a routine name' do
      body = {
        name: 'new_name'
      }

      put "/api/v1/routines/#{@routine.id}", params: body

      expect(response).to be_successful
      routine = JSON.parse(response.body, symbolize_names: true)
      expect(routine[:data][:id]).to eq(@routine.id.to_s)
      expect(routine[:data][:attributes][:name]).to eq(body[:name])
    end

    it 'cant update a routine name without a body' do
      put "/api/v1/routines/#{@routine.id}"

      expect(response.status).to eq(404)
    end

    it 'delete a routine' do
      delete "/api/v1/routines/#{@routine.id}"

      expect(response.status).to eq(204)

      get '/api/v1/routines'

      routines = JSON.parse(response.body, symbolize_names: true)
      expect(routines[:data].count).to eq(2)
      routine_ids = routines[:data].map do |routine|
        routine[:id]
      end
      expect(routine_ids).to_not include(@routine.id)
    end
  end
end

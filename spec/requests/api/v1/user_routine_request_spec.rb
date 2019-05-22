require 'rails_helper'

describe 'User Routines API' do
  describe 'Endpoints' do
    it 'can get a list of routines' do
      user = User.create(name: 'ME, the programmer')
      leg_day = Routine.create(name: 'Leg Day')
      single_leg_press = Exercise.create(name: 'Single-Leg Press', equipment_required: 'legs', muscle: 'legs', category: 'This')
      ExerciseRoutine.create(routine: leg_day, exercise: single_leg_press, sets: 4, reps: 12)
      today = Date.today
      UserRoutine.create(routine: leg_day, user: user, date: today)

      get "/api/v1/my_routines?date=#{today}&id=#{user.id}"

      expect(response).to be_successful
      routines = JSON.parse(response.body, symbolize_names: true)
      expect(routines[:data]).to be_a(Array)
      expect(routines[:data][0]).to be_a(Hash)
      expect(routines[:data][0].keys).to include(:id)
      expect(routines[:data][0][:type]).to eq("routine")
      expect(routines[:data][0][:attributes]).to include(:name)
      expect(routines[:data][0][:attributes][:exercises]).to be_a(Array)
      expect(routines[:data][0][:attributes][:exercises][0][:name]).to eq('Single-Leg Press')
      expect(routines[:data][0][:attributes][:exercises][0][:reps]).to eq(12)
    end
  end
end

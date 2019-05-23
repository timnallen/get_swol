require 'rails_helper'

describe 'User Routines API' do
  describe 'Endpoints' do
    before :each do
      @user = User.create(name: 'ME, the programmer')
      @leg_day = Routine.create(name: 'Leg Day')
      single_leg_press = Exercise.create(name: 'Single-Leg Press', equipment_required: 'legs', muscle: 'legs', category: 'This')
      ExerciseRoutine.create(routine: @leg_day, exercise: single_leg_press, sets: 4, reps: 12)
      @today = Date.today
      @user_routine = UserRoutine.create(routine: @leg_day, user: @user, date: @today)
    end

    it 'can get a list of routines' do
      get "/api/v1/my_routines?date=#{@today}&id=#{@user.id}"

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

    it 'can schedule a routine' do
      date = "2019-05-25"
      body = {
        date: date,
        routine_id: @leg_day.id,
        user_id: @user.id
      }

      post "/api/v1/my_routines", params: body

      ur = UserRoutine.last

      expect(response).to be_successful
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message[:message]).to eq("You have successfully scheduled #{@leg_day.name} on #{date}!")
      expect(ur.routine_id).to eq(@leg_day.id)
      expect(ur.user_id).to eq(@user.id)
      expect(ur.date.to_s).to eq(date)
    end

    it 'can cancel a routine' do
      delete "/api/v1/my_routines/#{@user_routine.id}?id=#{@user.id}"

      expect(response.code).to eq("204")

      get "/api/v1/my_routines?date=#{@today}&id=#{@user.id}"

      routines = JSON.parse(response.body, symbolize_names: true)
      expect(routines[:data].count).to eq(0)
    end
  end
end

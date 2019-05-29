require 'rails_helper'

describe 'User Routines API' do
  describe 'Endpoints' do
    before :each do
      @user = User.create(name: 'ME, the programmer', email: 'tim@email.com', password: '1', password_confirmation: '1', api_key: '1234567890')
      @leg_day = Routine.create(name: 'Leg Day')
      single_leg_press = Exercise.create(name: 'Single-Leg Press', equipment_required: 'legs', muscle: 'legs', category: 'This')
      ExerciseRoutine.create(routine: @leg_day, exercise: single_leg_press, sets: 4, reps: 12)
      @today = Date.today
      @user_routine = UserRoutine.create(routine: @leg_day, user: @user, date: @today)
    end

    it 'can get a list of routines' do
      get "/api/v1/my_routines?date=#{@today}&user_id=#{@user.id}&api_key=#{@user.api_key}"

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
        user_id: @user.id,
        api_key: @user.api_key
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

    it 'cant schedule a routine with the wrong api_key' do
      date = "2019-05-25"
      body = {
        date: date,
        routine_id: @leg_day.id,
        user_id: @user.id,
        api_key: '1'
      }

      post "/api/v1/my_routines", params: body

      expect(response.status).to eq(401)
    end

    it 'cant schedule a routine with no api_key' do
      date = "2019-05-25"
      body = {
        date: date,
        routine_id: @leg_day.id,
        user_id: @user.id
      }

      post "/api/v1/my_routines", params: body

      expect(response.status).to eq(401)
    end

    it 'can cancel a routine' do
      delete "/api/v1/my_routines?routine_id=#{@leg_day.id}&user_id=#{@user.id}&date=#{@today}"

      expect(response.code).to eq("204")

      get "/api/v1/my_routines?date=#{@today}&user_id=#{@user.id}&api_key=#{@user.api_key}"

      routines = JSON.parse(response.body, symbolize_names: true)
      expect(routines[:data].count).to eq(0)
    end

    it 'cannot cancel a routine without the correct info' do
      delete "/api/v1/my_routines"

      expect(response.code).to eq("404")
    end

    it 'cannot schedule a routine without the correct info' do
      post "/api/v1/my_routines", params: {
        user_id: @user.id,
        api_key: @user.api_key
      }

      expect(response.code).to eq("404")
    end

    it 'cannot get scheduled routines without an api_key' do
      get "/api/v1/my_routines?date=#{@today}&user_id=#{@user.id}"

      expect(response.code).to eq("401")
    end

    it 'cannot get scheduled routines with an incorrect api_key' do
      get "/api/v1/my_routines?date=#{@today}&user_id=#{@user.id}&api_key=1"

      expect(response.code).to eq("401")
    end
  end
end

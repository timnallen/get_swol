require 'rails_helper'

describe 'User Routines API' do
  describe 'Endpoints' do
    it 'allows me to add a user' do
      post '/api/v1/users', params: {name: 'Jim'}

      expect(response.status).to eq(201)
      message = JSON.parse(response.body, symbolize_names: true)
      expect(message[:message]).to eq("You have successfully created a user!")
      expect(User.last.name).to eq('Jim')
    end

    it 'does not allow me to add a user without a name' do
      post '/api/v1/users'

      expect(response.status).to eq(404)
    end
  end
end

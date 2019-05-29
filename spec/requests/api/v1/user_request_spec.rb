require 'rails_helper'

describe 'User Routines API' do
  describe 'Endpoints' do
    it 'allows me to add a user' do
      post '/api/v1/users', params: {
        name: 'Jim',
        email: 'email@email.com',
        password: 'hjfkhjk',
        password_confirmation: 'hjfkhjk'
      }

      expect(response.status).to eq(201)
      user = JSON.parse(response.body, symbolize_names: true)
      expect(user[:message]).to eq("You have successfully created a user!")
      expect(user[:user][:data].keys).to include(:id)
      expect(user[:user][:data][:attributes].keys).to include(:api_key)
      expect(user[:user][:data][:attributes][:api_key]).to_not eq(nil)
      expect(User.last.name).to eq('Jim')
    end

    it 'does not allow me to add a user without a name, email and password' do
      post '/api/v1/users'

      expect(response.status).to eq(404)
    end

    it 'does not allow me to add a user without a unique email' do
      User.create(name: 'Tim', email: 'email@email.com', password: 'hjfkhjk', password_confirmation: 'hjfkhjk')

      post '/api/v1/users', params: {
        name: 'Jim',
        email: 'email@email.com',
        password: 'hjfkhjk',
        password_confirmation: 'hjfkhjk'
      }

      expect(response.status).to eq(409)
    end
  end
end

require 'rails_helper'

describe 'User Routines API' do
  describe 'Endpoints' do
    it 'allows me to add a user' do
      post '/api/v1/users', params: {name: 'Jim'}

      expect(response.status).to eq("201")
      expect(User.last.name).to eq('Jim')
    end
  end
end

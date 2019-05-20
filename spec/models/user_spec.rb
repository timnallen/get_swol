require 'rails_helper'

RSpec.describe User, type: :model do
  before :each do
    @user = User.create(name: 'Jim')
  end

  it 'exists' do
    expect(@user).to be_a(User)
  end

  it 'has attributes' do
    expect(@user.name).to eq('Jim')
  end

  describe 'validations' do
    it { should validate_presence_of :name }
  end
end

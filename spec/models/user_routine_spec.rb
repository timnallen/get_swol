require 'rails_helper'

RSpec.describe UserRoutine, type: :model do
  before :each do
    user = User.create(name: 'Jim')
    routine = Routine.create(name: 'Leg Day')
    @user_routine = UserRoutine.create(routine: routine, user: user, date: Date.new(2019,5,20))
  end

  it 'exists' do
    expect(@user_routine).to be_a(UserRoutine)
  end

  it 'has attributes' do
    expect(@user_routine.date).to be_a(Date)
  end

  describe 'validations' do
    it { should validate_presence_of :date }
  end

  describe 'relationships' do
    it { should belong_to :user}
    it { should belong_to :routine}
  end
end

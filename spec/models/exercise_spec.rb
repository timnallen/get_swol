require 'rails_helper'

RSpec.describe Exercise, type: :model do
  before :each do
    @exercise = Exercise.create(name: 'Squats', category: 'Legs', equipment_required: 'None', muscle: 'Quadriceps')
  end

  it 'exists' do
    expect(@exercise).to be_a(Exercise)
  end

  it 'has attributes' do
    expect(@exercise.name).to eq('Squats')
    expect(@exercise.category).to eq('Legs')
    expect(@exercise.equipment_required).to eq('None')
  end

  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :category }
    it { should validate_presence_of :equipment_required }
    it { should validate_presence_of :muscle }
  end

  describe 'relationships' do
    it { should have_many :exercise_routines}
    it { should have_many :routines}
  end
end

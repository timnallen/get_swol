require 'rails_helper'

RSpec.describe Exercise, type: :model do
  before :each do
    @exercise = Exercise.create(name: 'Squats', category: 'Legs', equipment_required: 'None')
  end

  it 'exists' do
    expect(@exercise).to be_a(Exercise)
  end

  it 'has attributes' do
    expect(@exercise.name).to eq('Squats')
    expect(@exercise.category).to eq('Legs')
    expect(@exercise.equipment_required).to eq('None')
  end
end

require 'rails_helper'

RSpec.describe Routine, type: :model do
  before :each do
    @routine = Routine.create(name: 'Leg Day')
  end

  it 'exists' do
    expect(@routine).to be_a(Routine)
  end

  it 'has attributes' do
    expect(@routine.name).to eq('Leg Day')
  end
end

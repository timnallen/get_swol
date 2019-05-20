require 'rails_helper'

RSpec.describe User, type: :model do
  it "exists" do
    user = User.create(name: "Jim")
    expect(user).to be_a(User)
  end
end

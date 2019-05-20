class UserRoutine < ApplicationRecord
  belongs_to :routine
  belongs_to :user

  validates_presence_of :date
  validates_presence_of :user
  validates_presence_of :routine
end

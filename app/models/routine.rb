class Routine < ApplicationRecord
  has_many :user_routines
  has_many :users, through: :user_routines
  has_many :exercise_routines
  has_many :exercises, through: :exercise_routines

  validates_presence_of :name
end

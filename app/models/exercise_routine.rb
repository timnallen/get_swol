class ExerciseRoutine < ApplicationRecord
  belongs_to :routine
  belongs_to :exercise

  validates_presence_of :routine
  validates_presence_of :exercise
end

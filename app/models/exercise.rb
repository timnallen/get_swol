class Exercise < ApplicationRecord
  has_many :exercise_routines
  has_many :routines, through: :exercise_routines
  
  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :equipment_required
end

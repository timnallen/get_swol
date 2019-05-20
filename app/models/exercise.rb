class Exercise < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :category
  validates_presence_of :equipment_required
end

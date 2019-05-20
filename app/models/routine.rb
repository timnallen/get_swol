class Routine < ApplicationRecord
  has_many :user_routines
  has_many :users, through: :user_routines
  
  validates_presence_of :name
end

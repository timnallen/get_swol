class User < ApplicationRecord
  validates_presence_of :name
  has_many :user_routines
  has_many :routines, through: :user_routines
end

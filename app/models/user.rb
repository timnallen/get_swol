class User < ApplicationRecord
  validates_presence_of :name
  validates :password,
    confirmation: true
  validates :email,
    presence: true,
    uniqueness: true

  has_secure_password
  has_many :user_routines
  has_many :routines, through: :user_routines
end

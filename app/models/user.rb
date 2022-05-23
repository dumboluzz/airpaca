class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :alpacas
  has_many :bookings # as renter
  has_many :bookings_owner, through: :alpacas, source: :bookings # as owner
end

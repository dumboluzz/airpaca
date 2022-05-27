class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :alpacas, dependent: :destroy
  has_many :bookings, dependent: :destroy # as renter
  has_many :owner_bookings, through: :alpacas, source: :bookings, dependent: :destroy # as owner
end

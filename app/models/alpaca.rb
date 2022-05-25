class Alpaca < ApplicationRecord
  has_many :bookings, dependent: :destroy
  belongs_to :owner, foreign_key: "user_id", class_name: "User"
  has_many :renters, class_name: "User", through: :bookings, source: :renter

  has_many_attached :photos
end

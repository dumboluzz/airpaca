class Booking < ApplicationRecord
  belongs_to :alpaca
  belongs_to :renter, foreign_key: "user_id", class_name: "User" # renter
  has_one :owner, through: :alpaca # owner
end

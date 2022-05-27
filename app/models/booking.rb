class Booking < ApplicationRecord
  belongs_to :alpaca
  belongs_to :renter, foreign_key: "user_id", class_name: "User" # renter
  has_one :owner, through: :alpaca # owner

  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :full_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end

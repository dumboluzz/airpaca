class Booking < ApplicationRecord
  belongs_to :alpaca
  belongs_to :user # renter
  # belongs_to :user, through: :alpaca # owner
end

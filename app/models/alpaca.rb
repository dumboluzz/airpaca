class Alpaca < ApplicationRecord
  WOOL_TYPES = ["Suri", "Huacaya"]
  COLORS = ["white", "gray", "brown", "black"]

  has_many :bookings, dependent: :destroy
  belongs_to :owner, foreign_key: "user_id", class_name: "User"
  has_many :renters, class_name: "User", through: :bookings, source: :renter

  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_by_city,
    against: [ :address ],
    using: {
      tsearch: { prefix: true }
    }
end

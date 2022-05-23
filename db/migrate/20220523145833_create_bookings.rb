class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.references :alpaca, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.integer :full_price
      t.references :user, null: false, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

class CreateAlpacas < ActiveRecord::Migration[6.1]
  def change
    create_table :alpacas do |t|
      t.string :name
      t.string :nick_name
      t.integer :age
      t.integer :price_per_day
      t.integer :height
      t.integer :weight
      t.string :color
      t.string :wool_type
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end

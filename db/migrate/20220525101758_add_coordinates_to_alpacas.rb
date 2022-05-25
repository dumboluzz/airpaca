class AddCoordinatesToAlpacas < ActiveRecord::Migration[6.1]
  def change
    add_column :alpacas, :latitude, :float
    add_column :alpacas, :longitude, :float
  end
end

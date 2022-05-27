class AddDescriptionToAlpacas < ActiveRecord::Migration[6.1]
  def change
    add_column :alpacas, :description, :text
  end
end

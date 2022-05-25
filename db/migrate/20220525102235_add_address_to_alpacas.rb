class AddAddressToAlpacas < ActiveRecord::Migration[6.1]
  def change
    add_column :alpacas, :address, :string
  end
end

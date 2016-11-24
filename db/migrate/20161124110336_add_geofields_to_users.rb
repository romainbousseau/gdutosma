class AddGeofieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :zip_code, :integer
    add_column :users, :city, :string
    add_column :users, :country, :string
  end
end

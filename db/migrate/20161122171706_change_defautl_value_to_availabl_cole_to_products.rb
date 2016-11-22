class ChangeDefautlValueToAvailablColeToProducts < ActiveRecord::Migration[5.0]
  def change
    change_column :products, :available, :boolean, :default => true
  end
end

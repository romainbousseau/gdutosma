class ChangeDefaultValueOfPendingToRents < ActiveRecord::Migration[5.0]
  def change
    change_column :rents, :status, :string, :default => "pending"
  end
end

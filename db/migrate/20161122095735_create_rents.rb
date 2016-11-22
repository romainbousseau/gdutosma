class CreateRents < ActiveRecord::Migration[5.0]
  def change
    create_table :rents do |t|
      t.date :start_date
      t.date :end_date
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.string :status

      t.timestamps
    end
  end
end

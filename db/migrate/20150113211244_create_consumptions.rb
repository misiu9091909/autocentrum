class CreateConsumptions < ActiveRecord::Migration
  def change
    create_table :consumptions do |t|
      t.string :fuel_type
      t.float :min
      t.float :max
      t.float :min_long
      t.float :average
      t.float :official
      t.integer :count

      t.timestamps null: false
    end
  end
end

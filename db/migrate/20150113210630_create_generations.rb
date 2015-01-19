class CreateGenerations < ActiveRecord::Migration
  def change
    create_table :generations do |t|
      t.string :name
      t.string :link
      t.integer :start_year
      t.integer :end_year

      t.timestamps null: false
    end
  end
end

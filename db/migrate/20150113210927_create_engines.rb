class CreateEngines < ActiveRecord::Migration
  def change
    create_table :engines do |t|
      t.string :name
      t.string :link
      t.string :engine_type
      t.integer :start_year
      t.integer :end_year

      t.timestamps null: false
    end
  end
end

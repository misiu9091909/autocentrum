class CreateBodies < ActiveRecord::Migration
  def change
    create_table :bodies do |t|
      t.string :name
      t.string :link
      t.string :body_type
      t.integer :start_year
      t.integer :end_year
      t.hstore :techspec

      t.timestamps null: false
    end
  end
end

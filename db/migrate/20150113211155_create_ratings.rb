class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :ratings_count
      t.integer :again_count
      t.hstore :rates
      t.integer :again

      t.timestamps null: false
    end
  end
end

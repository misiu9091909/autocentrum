class CreateBeCombines < ActiveRecord::Migration
  def change
    create_table :be_combines do |t|
      t.string :name
      t.string :link
      t.integer :start_year
      t.integer :end_year
      t.hstore :techspec

      t.timestamps null: false
    end
  end
end

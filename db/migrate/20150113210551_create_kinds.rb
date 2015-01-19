class CreateKinds < ActiveRecord::Migration
  def change
    create_table :kinds do |t|
      t.string :name
      t.string :link
      t.string :segment

      t.timestamps null: false
    end
  end
end

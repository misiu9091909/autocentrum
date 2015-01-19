class AddKindToGenerations < ActiveRecord::Migration
  def change
    add_reference :generations, :kind, index: true
    add_foreign_key :generations, :kinds
  end
end

class AddBrandToKinds < ActiveRecord::Migration
  def change
    add_reference :kinds, :brand, index: true
    add_foreign_key :kinds, :brands
  end
end

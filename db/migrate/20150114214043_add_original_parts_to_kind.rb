class AddOriginalPartsToKind < ActiveRecord::Migration
  def change
    add_column :kinds, :original_parts, :integer
  end
end

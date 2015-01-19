class AddReplacementPartsToKind < ActiveRecord::Migration
  def change
    add_column :kinds, :replacement_parts, :integer
  end
end

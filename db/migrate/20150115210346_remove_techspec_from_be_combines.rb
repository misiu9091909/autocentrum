class RemoveTechspecFromBeCombines < ActiveRecord::Migration
  def change
    remove_column :be_combines, :techspec, :hstore
  end
end

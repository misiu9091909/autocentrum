class RemoveTechspecFromBodies < ActiveRecord::Migration
  def change
    remove_column :bodies, :techspec, :hstore
  end
end

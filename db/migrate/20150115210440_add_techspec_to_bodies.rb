class AddTechspecToBodies < ActiveRecord::Migration
  def change
    add_column :bodies, :techspec, :json
  end
end

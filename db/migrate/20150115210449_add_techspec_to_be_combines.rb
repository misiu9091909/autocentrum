class AddTechspecToBeCombines < ActiveRecord::Migration
  def change
    add_column :be_combines, :techspec, :json
  end
end

class AddBodyToBeCombines < ActiveRecord::Migration
  def change
    add_reference :be_combines, :body, index: true
    add_foreign_key :be_combines, :bodies
  end
end

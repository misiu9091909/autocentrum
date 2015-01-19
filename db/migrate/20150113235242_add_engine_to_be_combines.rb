class AddEngineToBeCombines < ActiveRecord::Migration
  def change
    add_reference :be_combines, :engine, index: true
    add_foreign_key :be_combines, :engines
  end
end

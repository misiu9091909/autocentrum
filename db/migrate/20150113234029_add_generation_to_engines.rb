class AddGenerationToEngines < ActiveRecord::Migration
  def change
    add_reference :engines, :generation, index: true
    add_foreign_key :engines, :generations
  end
end

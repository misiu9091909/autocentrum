class AddGenerationToBodies < ActiveRecord::Migration
  def change
    add_reference :bodies, :generation, index: true
    add_foreign_key :bodies, :generations
  end
end

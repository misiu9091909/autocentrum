class AddConsumableToConsumptions < ActiveRecord::Migration
  def change
    add_reference :consumptions, :consumable, polymorphic: true, index: true
  end
end

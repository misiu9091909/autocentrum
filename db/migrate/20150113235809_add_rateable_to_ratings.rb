class AddRateableToRatings < ActiveRecord::Migration
  def change
    add_reference :ratings, :rateable, polymorphic: true, index: true
  end
end

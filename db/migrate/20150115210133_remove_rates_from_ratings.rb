class RemoveRatesFromRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :rates, :hstore
  end
end

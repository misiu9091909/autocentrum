class AddRatesToRatings < ActiveRecord::Migration
  def change
    add_column :ratings, :rates, :json
  end
end

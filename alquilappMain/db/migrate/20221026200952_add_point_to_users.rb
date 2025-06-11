class AddPointToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :location_point, :point
  end
end

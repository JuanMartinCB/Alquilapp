class CreateRentals < ActiveRecord::Migration[7.0]
  def change
    create_table :rentals do |t|
      t.integer :user_id
      t.integer :vehicle_id
      t.point :start_point
      t.point :end_point
      t.string :state
      t.datetime :finish_at
      t.timestamps
      t.integer :range_hours
    end
  end
end

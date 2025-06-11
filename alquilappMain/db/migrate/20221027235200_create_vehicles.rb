class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.integer :did
      t.string :patent
      t.string :type
      t.string :brand
      t.string :model
      t.integer :year
      t.point :location, geographic: true
      t.string :image
      t.timestamps
    end
  end
end

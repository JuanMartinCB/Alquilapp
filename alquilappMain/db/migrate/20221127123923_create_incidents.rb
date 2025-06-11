class CreateIncidents < ActiveRecord::Migration[7.0]
  def change
    create_table :incidents do |t|
      t.integer :user_id
      t.integer :vehicle_id
      t.integer :rental_id
      t.text :description
      t.integer :supervisor_id

      t.timestamps
    end
  end
end

class CreateCooldowns < ActiveRecord::Migration[7.0]
  def change
    create_table :cooldowns do |t|
      t.integer :user_id
      t.string :vehicle_id
      t.string :integer
      t.timestamps
    end
  end
end

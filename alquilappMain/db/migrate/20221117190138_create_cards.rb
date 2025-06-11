class CreateCards < ActiveRecord::Migration[7.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.integer :number
      t.integer :company
      t.integer :wallet_id
      t.integer :expiration_day
      t.integer :expiration_month

      t.timestamps
    end
  end
end

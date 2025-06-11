class CreateWtransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :wtransactions do |t|
      t.integer :wallet_id
      t.integer :card_id
      t.integer :balance
      t.integer :entry
      t.string :new_balance
      t.string :integer

      t.timestamps
    end
  end
end

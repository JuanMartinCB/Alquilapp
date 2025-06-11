class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.integer :user_id
      t.integer :balance, default: 0

      t.timestamps
    end
  end
end

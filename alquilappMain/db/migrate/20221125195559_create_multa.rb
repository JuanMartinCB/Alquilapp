class CreateMulta < ActiveRecord::Migration[7.0]
  def change
    create_table :multa do |t|
      t.integer :monto
      t.string :razon
      t.integer :user_id
      t.integer :supervisor_id
      t.timestamps
    end
  end
end

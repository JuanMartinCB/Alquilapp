class AddCvcColumnToWtransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :wtransactions, :cvc, :integer
  end
end

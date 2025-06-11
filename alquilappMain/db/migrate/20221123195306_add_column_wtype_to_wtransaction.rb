class AddColumnWtypeToWtransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :wtransactions, :wtype, :string
  end
end

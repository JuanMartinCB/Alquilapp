class AddColumTicktetIdToWtransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :wtransactions, :ticket_id, :integer
  end
end

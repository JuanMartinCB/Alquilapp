class RemoveColumnIntegerFromWtransactions < ActiveRecord::Migration[7.0]
  def change
    remove_column :wtransactions, :integer, :string
  end
end

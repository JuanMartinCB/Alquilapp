class ChangeNumberOfCardDataTypeToBigint < ActiveRecord::Migration[7.0]
  def change
    change_column :cards, :number, :bigint
  end
end

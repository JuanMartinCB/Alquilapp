class AddColumnToCardCvc < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :cvc, :integer
  end
end

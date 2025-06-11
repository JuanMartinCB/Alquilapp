class AddTwoColumnsToRentals < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :cost, :integer, default: 0
    add_column :rentals, :extra_cost, :integer, default: 0
  end
end

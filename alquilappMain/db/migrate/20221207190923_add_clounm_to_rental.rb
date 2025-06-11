class AddClounmToRental < ActiveRecord::Migration[7.0]
  def change
    add_column :rentals, :overlimit, :integer
  end
end

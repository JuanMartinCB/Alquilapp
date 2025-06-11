class ChangeRangeHoursToHoursInRental < ActiveRecord::Migration[7.0]
  def change
    rename_column :rentals, :range_hours, :hours
  end
end

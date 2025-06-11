class RenameColumnInCardExpirationDayToExpirationYear < ActiveRecord::Migration[7.0]
  def change
    rename_column :cards, :expiration_day, :expiration_year
  end
end

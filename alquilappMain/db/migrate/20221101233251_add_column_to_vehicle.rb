class AddColumnToVehicle < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :features, :string, array: true, default: []
  end
end

class AddStateToVehicles < ActiveRecord::Migration[7.0]
  def change
    add_column :vehicles, :state, :string
  end
end

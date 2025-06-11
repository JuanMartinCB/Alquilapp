class RemoveColumnVehicle < ActiveRecord::Migration[7.0]
  def change
    remove_column :vehicles, :image, :string
  end
end

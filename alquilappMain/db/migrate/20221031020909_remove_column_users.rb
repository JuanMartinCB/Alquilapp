class RemoveColumnUsers < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :license
  end
end

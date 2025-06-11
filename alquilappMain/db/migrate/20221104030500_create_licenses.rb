class CreateLicenses < ActiveRecord::Migration[7.0]
  def change
    create_table :licenses do |t|
      t.integer :user_id
      t.boolean :authorized, default: false
      t.boolean :checked,  default: false

      t.timestamps
    end
  end
end

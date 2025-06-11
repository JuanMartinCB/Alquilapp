class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :wt_id
      t.integer :rental_id

      t.timestamps
    end
  end
end

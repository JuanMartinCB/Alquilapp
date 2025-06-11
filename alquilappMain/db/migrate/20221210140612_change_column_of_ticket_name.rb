class ChangeColumnOfTicketName < ActiveRecord::Migration[7.0]
  def change
    rename_column :tickets, :wt_id, :wtransaction_id
  end
end

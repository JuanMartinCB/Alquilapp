
class AddColumnCtypeToCard < ActiveRecord::Migration[7.0]
  def change
    add_column :cards, :ctype, :string
  end
end

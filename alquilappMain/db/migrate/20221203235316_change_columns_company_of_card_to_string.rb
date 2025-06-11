class ChangeColumnsCompanyOfCardToString < ActiveRecord::Migration[7.0]
  def change
    change_column :cards, :company, :string
  end
end

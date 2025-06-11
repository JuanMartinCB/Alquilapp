json.extract! wtransaction, :id, :wallet_id, :card_id, :balance, :entry, :new_balance, :integer, :created_at, :updated_at
json.url wtransaction_url(wtransaction, format: :json)

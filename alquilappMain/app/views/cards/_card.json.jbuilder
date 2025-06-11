json.extract! card, :id, :name, :number, :company, :wallet_id, :created_at, :updated_at
json.url card_url(card, format: :json)

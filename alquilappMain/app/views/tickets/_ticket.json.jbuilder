json.extract! ticket, :id, :user_id, :wt_id, :rental_id, :created_at, :updated_at
json.url ticket_url(ticket, format: :json)

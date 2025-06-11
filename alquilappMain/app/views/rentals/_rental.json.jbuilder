json.extract! rental, :id, :user_id, :vehicle_id, :start_point, :end_point, :state, :finish_at, :created_at, :updated_at
json.url rental_url(rental, format: :json)

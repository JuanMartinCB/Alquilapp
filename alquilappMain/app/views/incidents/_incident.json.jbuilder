json.extract! incident, :id, :user_id, :vehicle_id, :description, :created_at, :updated_at
json.url incident_url(incident, format: :json)

json.extract! customer, :id, :name, :email, :approved, :tracking_id, :created_at, :updated_at
json.url customer_url(customer, format: :json)

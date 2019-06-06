json.extract! con_staff, :id, :name, :title, :phone, :email, :event_id, :created_at, :updated_at
json.url con_staff_url(con_staff, format: :json)

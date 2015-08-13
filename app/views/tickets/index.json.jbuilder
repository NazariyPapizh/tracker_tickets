json.array!(@tickets) do |ticket|
  json.extract! ticket, :id, :name, :email, :subject, :full_body
  json.url ticket_url(ticket, format: :json)
end

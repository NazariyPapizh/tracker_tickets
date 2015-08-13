json.array!(@ticket_statuses) do |ticket_status|
  json.extract! ticket_status, :id, :name
  json.url ticket_status_url(ticket_status, format: :json)
end

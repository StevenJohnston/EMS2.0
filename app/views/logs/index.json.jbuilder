json.array!(@logs) do |log|
  json.extract! log, :id, :employeeInfo, :additionalInfo
  json.url log_url(log, format: :json)
end

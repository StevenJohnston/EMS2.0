json.array!(@employees) do |employee|
  json.extract! employee, :id, :lastName, :firstName, :sin, :dateOfBirth, :reasonForLeaving, :company_id
  json.url employee_url(employee, format: :json)
end

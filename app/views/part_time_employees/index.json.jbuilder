json.array!(@part_time_employees) do |part_time_employee|
  json.extract! part_time_employee, :id, :dateOfHire, :dateOfTermination, :hourlyRate
  json.url part_time_employee_url(part_time_employee, format: :json)
end

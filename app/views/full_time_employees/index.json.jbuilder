json.array!(@full_time_employees) do |full_time_employee|
  json.extract! full_time_employee, :id, :dateOfHire, :dateofTermination, :salary, :employee_id
  json.url full_time_employee_url(full_time_employee, format: :json)
end

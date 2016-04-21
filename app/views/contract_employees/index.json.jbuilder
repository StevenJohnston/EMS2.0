json.array!(@contract_employees) do |contract_employee|
  json.extract! contract_employee, :id, :contractStartDate, :contractStopDate, :fixedContractAmount, :employee_id, :verified
  json.url contract_employee_url(contract_employee, format: :json)
end

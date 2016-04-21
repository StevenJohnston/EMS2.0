json.array!(@seasonals) do |seasonal|
  json.extract! seasonal, :id, :season, :seasonYear, :piecePay, :employee_id, :verified
  json.url seasonal_url(seasonal, format: :json)
end

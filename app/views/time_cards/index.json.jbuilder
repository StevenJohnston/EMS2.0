json.array!(@time_cards) do |time_card|
  json.extract! time_card, :id, :dateOf, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday
  json.url time_card_url(time_card, format: :json)
end

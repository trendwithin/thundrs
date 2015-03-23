json.array!(@memories) do |memory|
  json.extract! memory, :id, :name, :keywords, :description, :creator_id
  json.url memory_url(memory, format: :json)
end

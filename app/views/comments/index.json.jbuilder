json.array!(@comments) do |comment|
  json.extract! comment, :id, :body, :author_id, :memory_id, :approved
  json.url comment_url(comment, format: :json)
end

json.extract! api_todo_list, :id, :title, :is_current
json.author do
  json.extract! api_todo_list.author, :id, :name
end
json.todo_list_items do
  json.array! api_todo_list.todo_list_items do |todo_list_item|
    json.extract! todo_list_item, :id, :content, :status
  end
end

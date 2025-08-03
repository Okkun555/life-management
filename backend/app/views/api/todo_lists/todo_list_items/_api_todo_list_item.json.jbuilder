json.extract! api_todo_list_item, :id, :content, :status
json.author do
  json.extract! api_todo_list_item.author, :id, :name if api_todo_list_item.author
end
json.todo_list do
  json.extract! api_todo_list_item.todo_list, :id, :title if api_todo_list_item.todo_list
end

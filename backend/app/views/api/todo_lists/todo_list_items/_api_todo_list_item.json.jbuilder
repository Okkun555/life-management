json.extract! api_todo_list_item, :id, :content, :status
if api_todo_list_item.todo_list
  json.todo_list do
    json.extract! api_todo_list_item.todo_list, :id, :title
    if api_todo_list_item.todo_list&.author
      json.author do
        json.extract! api_todo_list_item.todo_list.author, :id, :name
      end
    end
  end
end

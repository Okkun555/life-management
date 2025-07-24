json.extract! api_todo_review, :id, :review
json.author do
  json.extract! api_todo_review.author, :id, :name if api_todo_review.author
end
json.todo_list do
  json.extract! api_todo_review.todo_list, :id, :title if api_todo_review.todo_list
end

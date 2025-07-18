class TodoListItem < ApplicationRecord
  validates :content, presence: true, length: { maximum: 140 }

  enum :status, { pending: 1, completed: 2 }, default: :pending

  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :todo_list_items
  belongs_to :todo_list
end

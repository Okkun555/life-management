class TodoReview < ApplicationRecord
  validates :review, presence: true

  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :todo_reviews
  belongs_to :todo_list
end

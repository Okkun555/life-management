class TodoList < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :is_current, inclusion: { in: [true, false] }

  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :todo_lists
  has_many :todo_list_items, dependent: :destroy
  has_one :todo_review, dependent: :destroy

  scope :by_author, ->(user) { where(author: user) }
  scope :ordered_by_date, -> { order(title: :desc) }
end

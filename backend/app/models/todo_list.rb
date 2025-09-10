class TodoList < ApplicationRecord
  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :is_current, inclusion: { in: [true, false] }

  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :todo_lists
  has_many :todo_list_items, -> { order(created_at: :desc) }, dependent: :destroy, inverse_of: :todo_list
  has_one :todo_review, dependent: :destroy

  scope :by_author, ->(user) { where(user_id: user.id) }
  scope :ordered_by_date, -> { order(title: :desc) }

  def completed_rate
    return nil if todo_list_items.empty?

    completed_count = todo_list_items.completed.count.to_f
    total_count = todo_list_items.count.to_f

    ((completed_count / total_count) * 100).round
  end

  class << self
    def create_current_todo_list(user)
      # MEMO: バッチ以外でTODO作成できるのはauthorに紐づくTODOリストが存在しない場合のみ
      raise StandardError, '本日のTODOリストはすでに存在します' if by_author(user).present?

      create(title: Time.zone.today.strftime('%Y/%m/%d'), is_current: true, author: user)
    end
  end
end

class User < ApplicationRecord
  validates :supabase_uid, presence: true, uniqueness: true

  has_many :todo_lists, dependent: :destroy
  has_many :todo_list_items, dependent: :destroy
  has_many :todo_reviews, dependent: :destroy

  def self.create_daily_todo_lists
    formatted_date = Date.current.strftime('%Y-%m-%d')

    find_each do |user|
      next if user.todo_lists.find_by(title: formatted_date)

      user.todo_lists.create!(
        title: formatted_date,
        is_current: true
      )
    end
  end

  def self.reset_previous_current_todo_lists
    find_each do |user|
      # パフォーマンス考慮 x is_currentは単純なbooleanなので、update_allを許容
      # rubocop:disable Rails/SkipsModelValidations
      user.todo_lists.where(is_current: true).update_all(is_current: false)
    end
  end
end

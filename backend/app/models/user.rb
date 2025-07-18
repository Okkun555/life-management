class User < ApplicationRecord
  validates :supabase_uid, presence: true, uniqueness: true

  has_many :todo_lists, dependent: :destroy

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
end

class MissionStatement < ApplicationRecord
  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :mission_statements

  validates :content, presence: true, length: { maximum: 100 }
  validates :version, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
end

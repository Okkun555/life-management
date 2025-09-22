class MissionStatementValue < ApplicationRecord
  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :mission_statement_values

  validates :content, presence: true, length: { maximum: 2000 }
end

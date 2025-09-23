class MissionStatementGoal < ApplicationRecord
  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :mission_statement_goals
  belongs_to :role

  validates :goal, presence: true, length: { maximum: 140 }
end

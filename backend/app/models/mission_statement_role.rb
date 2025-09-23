class MissionStatementRole < ApplicationRecord
  belongs_to :author, foreign_key: 'user_id', class_name: 'User', inverse_of: :mission_statement_roles

  validates :role, presence: true, length: { maximum: 100 }
end

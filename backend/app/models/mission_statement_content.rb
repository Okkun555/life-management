class MissionStatementContent < ApplicationRecord
  belongs_to :mission_statement

  validates :content, presence: true, length: { maximum: 20_000 }
end

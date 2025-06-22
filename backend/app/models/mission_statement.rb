class MissionStatement < ApplicationRecord
  has_many :mission_statement_contents, dependent: :destroy

  validates :name, presence: true, length: { maximum: 100 }
end

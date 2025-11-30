class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :body_part

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: [:user_id, :body_part_id] }
  validates :description, length: { maximum: 100 }
end

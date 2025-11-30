class Workout < ApplicationRecord
  belongs_to :user
  belongs_to :body_part

  validates :name, presence: true, length: { maximum: 50 }, uniqueness: { scope: :user }
  validates :description, length: { maximum: 100 }
end

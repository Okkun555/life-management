class Profile < ApplicationRecord
  belongs_to :user

  validates :birthday, presence: true,
                       comparison: { greater_than_or_equal_to: Date.new(1900, 1, 1), less_than_or_equal_to: Date.current }
  validates :sex, presence: true
  validates :is_public, inclusion: { in: [true, false] }

  enum :sex, { secret: 0, man: 1, woman: 2 }
end

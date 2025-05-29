class MissionStatement < ApplicationRecord
  validates :content, presence: true, length: { maximum: 20_000 }
end

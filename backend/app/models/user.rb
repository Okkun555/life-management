class User < ApplicationRecord
  with_options dependent: :destroy do
    has_one :profile
    has_many :body_parts
    has_many :workouts
  end

  validates :supabase_uid, presence: true, uniqueness: true
end

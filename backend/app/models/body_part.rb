class BodyPart < ApplicationRecord
  has_ancestry

  belongs_to :user
  has_many :exercises, dependent: :destroy

  def full_name
    @full_name ||= ancestors.pluck(:name).push(name).join('/')
  end

  class << self
    def create_with_ancestry!(parent_id:, name:, user:)
      attributes = { name:, user: }

      if parent_id.present?
        parent = user.body_parts.find(parent_id)
        parent.children.create!(attributes)
      else
        create!(attributes)
      end
    end
  end
end

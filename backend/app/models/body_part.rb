class BodyPart < ApplicationRecord
  has_ancestry
  has_many :exercises, dependent: :destroy
end

class TodoReviewPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end

class TodoListItemPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end

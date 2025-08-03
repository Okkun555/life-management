# frozen_string_literal: true

class Api::TodoLists::TodoListItemBaseController < ApplicationController
  private

  def set_todo_list
    @todo_list ||= @current_user.todo_lists.find(params[:todo_list_id])
  end
end

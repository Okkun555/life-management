# frozen_string_literal: true

class Api::TodoListItemBaseController < ApplicationController
  before_action :set_todo_list, :set_todo_list_item

  private

  def set_todo_list
    @todo_list ||= @current_user.todo_lists.find(params[:todo_list_id])
  end

  def set_todo_list_item
    todo_list_item_id = params[:id] || params[:todo_list_item_id]
    @todo_list_item ||= @todo_list.todo_list_items.find(todo_list_item_id)
  end
end

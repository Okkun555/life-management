# frozen_string_literal: true

class Api::TodoLists::TodoListItemBaseController < ApplicationController
  private

  def set_todo_list
    @todo_list ||= @current_user.todo_lists.find_by(id: params[:todo_list_id])
    head :not_found if @todo_list.nil?
  end
end

class Api::TodoListsController < ApplicationController
  def index
    @todo_lists = TodoList.preload(:author, :todo_list_items).by_author(current_user).ordered_by_date
    render :index, status: :ok
  end

  def show
    @todo_list = TodoList.preload(:author, :todo_list_items).find(params[:id])
    render :show, status: :ok
  end

  def latest
    @todo_list = TodoList.preload(:author, :todo_list_items).by_author(current_user).find_by(is_current: true)

    raise StandardError, '本日対象のTODOリストが存在しません' if @todo_list.nil?

    render :show, status: :ok
  end
end

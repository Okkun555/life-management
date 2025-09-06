class Api::TodoListsController < ApplicationController
  def index
    @todo_lists = TodoList.preload(:author, :todo_list_items).by_author(current_user).ordered_by_date
    render :index, status: :ok
  end

  def show
    @todo_list = TodoList.preload(:author, :todo_list_items).find(params[:id])
    render :show, status: :ok
  end

  def create
    @todo_list = TodoList.create_current_todo_list(current_user)
    render :show, status: :created
  end

  def latest
    @todo_list = TodoList.preload(:author, :todo_list_items).by_author(current_user).find_by(is_current: true)

    render :show, status: :ok
  end
end

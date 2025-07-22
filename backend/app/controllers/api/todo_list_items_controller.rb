class Api::TodoListItemsController < ApplicationController
  before_action :set_todo_list

  def create
    @todo_list_item = @todo_list.todo_list_items.build(todo_list_item_params.merge(author: @current_user))

    if @todo_list_item.save
      render :show, status: :created, location: api_todo_list_todo_list_item_url(@todo_list, @todo_list_item, format: :json)
    else
      render json: { errors: @todo_list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @todo_list_item = @todo_list.todo_list_items.find(params[:id])

    if @todo_list_item.update(todo_list_item_params)
      render :show, status: :ok, location: api_todo_list_todo_list_item_url(@todo_list, @todo_list_item, format: :json)
    else
      render json: { errors: @todo_list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def todo_list_item_params
    params.require(:todo_list_item).permit(:content)
  end

  def set_todo_list
    @todo_list ||= @current_user.todo_lists.find(params[:todo_list_id])
  end
end

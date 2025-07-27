# frozen_string_literal: true

class Api::TodoListItemsController < Api::TodoListItemBaseController
  before_action :set_todo_list_item, only: [:update, :destroy]

  def create
    authorize TodoListItem
    @todo_list_item = @todo_list.todo_list_items.build(todo_list_item_params.merge(author: @current_user))

    if @todo_list_item.save
      render :show, status: :created, location: api_todo_list_todo_list_item_url(@todo_list, @todo_list_item, format: :json)
    else
      render json: { errors: @todo_list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    return head :not_found if @todo_list_item.nil?

    if @todo_list_item.update(todo_list_item_params)
      render :show, status: :ok, location: api_todo_list_todo_list_item_url(@todo_list, @todo_list_item, format: :json)
    else
      render json: { errors: @todo_list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    return head :not_found if @todo_list_item.nil?

    if @todo_list_item.destroy
      head :no_content
    else
      render json: { errors: @todo_list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def todo_list_item_params
    params.require(:todo_list_item).permit(:content)
  end
end

# frozen_string_literal: true

class Api::TodoLists::TodoListItemStatusesController < Api::TodoLists::TodoListItemBaseController
  before_action :set_todo_list, only: [:update]
  before_action :set_todo_list_item, only: [:update]

  def update
    return head :not_found if @todo_list_item.nil?

    unless TodoListItem.statuses.key?(params[:status])
      return render json: { errors: ['ステータスが不正です'] }, status: :unprocessable_entity
    end

    if @todo_list_item.update(status: params[:status])
      render 'api/todo_lists/todo_list_items/show',
             status: :ok,
             location: api_todo_list_todo_list_item_url(@todo_list, @todo_list_item, format: :json)
    else
      render json: { errors: @todo_list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_todo_list_item
    @todo_list_item ||= @todo_list.todo_list_items.find(params[:todo_list_item_id])
  end
end

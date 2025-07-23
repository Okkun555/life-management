# frozen_string_literal: true

class Api::TodoListItemStatusesController < Api::TodoListItemBaseController
  def update
    return head :not_found if @todo_list_item.nil?

    unless TodoListItem.statuses.key?(params[:status])
      return render json: { errors: ['ステータスが不正です'] }, status: :unprocessable_entity
    end

    if @todo_list_item.update(status: params[:status])
      render 'api/todo_list_items/show', status: :ok,
                                         location: api_todo_list_todo_list_item_url(@todo_list, @todo_list_item, format: :json)
    else
      render json: { errors: @todo_list_item.errors.full_messages }, status: :unprocessable_entity
    end
  end
end

class Api::TodoReviewsController < ApplicationController
  before_action :set_todo_list

  def create
    @todo_review = @set_todo_list.build_todo_review(todo_review_params.merge(author: @current_user))

    if @todo_review.save
      render :show, status: :created, location: api_todo_list_todo_review_url(@set_todo_list, @todo_review, format: :json)
    else
      render json: { errors: @todo_review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    return head :not_found if @set_todo_list.todo_review.nil?

    @todo_review = @set_todo_list.todo_review
    if @todo_review.update(todo_review_params)
      render :show, status: :ok, location: api_todo_list_todo_review_url(@set_todo_list, @todo_review, format: :json)
    else
      render json: { errors: @todo_review.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def todo_review_params
    params.require(:todo_review).permit(:review)
  end

  def set_todo_list
    @set_todo_list ||= @current_user.todo_lists.find(params[:todo_list_id])
  end
end

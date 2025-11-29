class Api::BodyPartsController < ApplicationController
  before_action :set_body_part, only: [:destroy]
  def index
    @body_parts = current_user.body_parts
    render :index, status: :ok
  end

  def create
    parent_id = body_part_params[:parent_id]
    name = body_part_params[:name]

    ActiveRecord::Base.transaction do
      BodyPart.create_with_ancestry!(parent_id:, name:, user: current_user)
    end

    head :created
  rescue ActiveRecord::RecordNotFound
    render_error('errors.resources.body_part.parent_not_found', status: :not_found)
  end

  def destroy
    return render_error('errors.resources.body_part.not_found', status: :not_found) if @body_part.nil?

    @body_part.destroy
    head :ok
  end

  private

  def body_part_params
    params.require(:body_part).permit(:name, :parent_id)
  end

  def set_body_part
    @body_part ||= current_user.body_parts.find_by(id: params[:id]) # rubocop:disable Naming/MemoizedInstanceVariableName
  end
end

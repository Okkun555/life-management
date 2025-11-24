class Api::BodyPartsController < ApplicationController
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

  private

  def body_part_params
    params.require(:body_part).permit(:name, :parent_id)
  end
end

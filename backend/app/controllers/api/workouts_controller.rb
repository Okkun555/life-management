class Api::WorkoutsController < ApplicationController
  def create
    body_part_id = workout_params[:body_part_id]
    return render_error('errors.resources.body_part.not_found', status: :not_found) unless BodyPart.find_by(id: body_part_id)

    current_user.workouts.create!(workout_params)
    head :created
  end

  private

  def workout_params
    params.require(:workout).permit(:name, :description, :body_part_id)
  end
end

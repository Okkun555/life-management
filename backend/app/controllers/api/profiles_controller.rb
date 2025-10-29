class Api::ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :update]

  def show
    if @profile
      render :show, status: :ok
    else
      render_error('errors.resources.profile.not_found', status: :not_found)
    end
  end

  def create
    if current_user.profile.blank?
      @profile = current_user.build_profile(profile_params)
      @profile.save!

      head :created
    else
      render_error('errors.resources.profile.already_exists', status: :conflict)
    end
  end

  def update
    if @profile.present?
      @profile.update!(profile_params)

      head :no_content
    else
      render_error('errors.resources.profile.not_found', status: :not_found)
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:birthday, :sex, :is_public, :avatar)
  end

  def set_profile
    @profile ||= current_user.profile # rubocop:disable Naming/MemoizedInstanceVariableName
  end
end

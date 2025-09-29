class Api::ProfilesController < ApplicationController
  before_action :set_profile, only: [:update]

  def create
    if current_user.profile.blank?
      @profile = current_user.build_profile(profile_params)
      @profile.save!

      head :created
    else
      render json: {
        error: 'プロフィールはすでに存在します'
      }, status: :conflict
    end
  end

  def update
    if @profile.present?
      @profile.update!(profile_params)

      head :no_content
    else
      render json: {
        error: 'プロフィールは存在しません'
      }, status: :not_found
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:birthday, :sex, :is_public)
  end

  def set_profile
    @profile ||= current_user.profile # rubocop:disable Naming/MemoizedInstanceVariableName
  end
end

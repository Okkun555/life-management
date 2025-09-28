class Api::ProfilesController < ApplicationController
  def create
    if current_user.profile.blank?
      @profile = current_user.build_profile(profile_params)
      @profile.save!

      render :show, status: :created
    else
      render json: {
        error: 'プロフィールはすでに存在します'
      }, status: :unprocessable_entity
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:birthday, :sex, :is_public)
  end
end

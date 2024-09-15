class ProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :check_avatar, only: [:edit, :show, :update]

  def show
    @user = current_user
    @profile = @user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    if @profile.save
      render json: { message: 'Profile updated successfully' }
    else
      render json: { error: 'Failed to update profile' }, status: :unprocessable_entity
    end
  end

  def edit
    profile = current_user.profile
    avatar_status = profile&.avatar&.attached? || false
    render json: {
      hasAvatar: avatar_status,
      avatarUrl: url_for(profile.avatar)
    }
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar)
  end

end

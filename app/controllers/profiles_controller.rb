class ProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :check_avatar, only: [:edit, :show, :update]

  def show
    @user = current_user
    @posts = @user.posts
    @profile = @user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    @profile.assign_attributes(profile_params)
    @profile.save!
    render json: { message: 'Profile updated successfully' }
  end

  def edit        #フロント側にアバターをアップロードの有無と有の場合画像のurlを返す
    profile = current_user.profile
    avatar_status = profile&.avatar&.attached? || false
    render json: {
      hasAvatar: avatar_status,
      avatarUrl: url_for(profile&.avatar)
    }
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar)
  end

end

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
      redirect_to profile_path, notice: 'プロフィール更新成功！'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  def edit
    profile = current_user.profile
    avatar_status = profile&.avatar&.attached? || false
    render json: { hasAvatar: avatar_status }
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar)
  end

end

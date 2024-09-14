class ProfilesController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :check_avatar, only: [:edit, :show, :update]

  def show
    @user = current_user
    @profile = @user.prepare_profile
  end

  def update
    @profile = current_user.prepare_profile
    binding.pry
    @profile.assign_attributes(profile_params)
    if @profile.save
      redirect_to profile_path, notice: 'プロフィール更新成功！'
    else
      flash.now[:error] = '更新に失敗しました'
      render :edit
    end
  end

  private

  def profile_params
    params.require(:profile).permit(:avatar)
  end

end

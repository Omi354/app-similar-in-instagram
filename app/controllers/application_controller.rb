class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :check_avatar

  protected
  # Deviseのストロングパラメーターをカスタマイズ
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end

  private
  def check_avatar
    if user_signed_in?
      unless current_user.profile.present?
        redirect_to profile_path, notice: 'アバター画像を設定してください。'
        return
      end

      unless current_user.profile.avatar.present?
        redirect_to profile_path, notice: 'アバター画像を設定してください。'
      end
    end
  end

end

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up)
  end

  def set_profiles
    @profiles = current_user.profiles.all if user_signed_in?
  end

  def set_current_profile
    if (cp = Profile.find_by(id: session[:current_profile_id]))
      @current_profile = cp
    else
      @current_profile = nil
    end
  end

  def no_current_profile
    unless session[:current_profile_id]
      flash[:danger] = "プロフィールを作成し選択してください。"
      redirect_to root_path
    end
  end
end

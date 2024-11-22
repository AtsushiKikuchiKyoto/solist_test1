class SoundsController < ApplicationController
  before_action :authenticate_user!
  before_action :no_current_profile, only:[:new, :create]
  before_action :not_your_sound, only:[:edit, :update, :destroy]
  before_action :set_profiles, only:[:new, :create, :edit, :update]
  before_action :set_sound, only: [:show, :edit, :update, :destroy]
  before_action :set_current_profile, only: [:new, :create, :edit, :update]

  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(sound_params)
    if @sound.save
      flash[:success] = "サウンドを作成しました。"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @sound.update(sound_params)
      flash[:success] = "サウンドを編集しました。"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sound.destroy
    flash[:info] = "サウンドを削除しました。"
    redirect_to root_path
  end

  private
  def sound_params
    params.require(:sound).permit(:text, :sound).merge(profile_id: params[:profile_id])
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

  def set_sound
    @sound = Sound.find(params[:id])
  end

  def no_current_profile
    unless session[:current_profile_id]
      flash[:danger] = "プロフィールを作成し選択してください。"
      redirect_to root_path
    end
  end

  def not_your_sound
    sound_user = Sound.find(params[:id]).profile.user
    unless current_user == sound_user
      flash[:danger] = "別のユーザーのサウンドです。"
      redirect_to root_path
    end
  end
end

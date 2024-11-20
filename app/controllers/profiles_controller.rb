class ProfilesController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_profiles, except: [:switch]
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_current_profile, only: [:index, :new, :edit, :show]
  before_action :switch_current_profile, only: [:switch]
  before_action :set_sounds, only: [:index]


  def index
  end

  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      session[:current_profile_id] = @profile.id
      flash[:success] = "プロフィールが作成されました。アバターアイコンから選択可能です。"
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @sounds = Sound.where(profile_id: params[:id]).order('created_at DESC').includes(:profile, comments: :profile)
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      flash[:success] = "プロフィールを編集しました。"
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    session[:current_profile_id] = nil
    flash[:info] = "プロフィールが削除されました。"
    redirect_to root_path
  end

  def switch
    flash[:success] = "プロフィールを切り替えました。"
    redirect_to(request.referer || root_path)
  end
  
  private
  def profile_params
    params.require(:profile).permit(:image, :name, :text).merge(user_id: current_user.id)
  end

  def set_profiles
    @profiles = current_user.profiles.all if user_signed_in?
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def switch_current_profile
    session[:current_profile_id] = params[:format]
    @current_profile = Profile.find(params[:format])
  end

  def set_current_profile
    if session[:current_profile_id] == nil
      @current_profile = nil
    else
      @current_profile = Profile.find(session[:current_profile_id])
    end
  end

  def set_sounds
    @sounds = Sound.all.order('created_at DESC').includes(:profile, comments: :profile)
  end

end

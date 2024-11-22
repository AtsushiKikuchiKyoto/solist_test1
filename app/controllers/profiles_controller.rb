class ProfilesController < ApplicationController
  before_action :authenticate_user!,  except: [:index]
  before_action :no_current_profile,  only: [:edit, :update, :destroy]
  before_action :not_current_profile, only: [:edit, :update, :destroy]
  before_action :set_profiles,        except: [:switch]
  before_action :set_profile,         only: [:show, :edit, :update, :destroy]
  before_action :set_current_profile, only: [:index, :new, :edit, :show]

  def index
    @sounds = Sound.all.order('created_at DESC').includes(:profile, comments: :profile)
  end

  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(image_resize(profile_params))
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
    if @profile.update(image_resize(profile_params))
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
    session[:current_profile_id] = params[:format]
    @current_profile = Profile.find(params[:format])
    flash[:success] = "プロフィールを切り替えました。"
    redirect_to(request.referer || root_path)
  end
  
  private
  def profile_params
    params.require(:profile).permit(:image, :name, :text).merge(user_id: current_user.id)
  end

  def image_resize(params)
    if params[:image]
      params[:image].tempfile = ImageProcessing::MiniMagick.source(params[:image].tempfile).resize_to_limit(100, 100).call
    end
    params
  end

  def set_profile
    @profile = Profile.find(params[:id])
  end

  def not_current_profile
    unless session[:current_profile_id] && session[:current_profile_id] == params[:id]
      flash[:danger] = "プロフィールが異なります。"
      redirect_to root_path
    end
  end
end

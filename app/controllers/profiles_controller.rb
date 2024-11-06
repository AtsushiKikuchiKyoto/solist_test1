class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profiles, except: [:switch]
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :set_current_profile, only: [:index, :new, :edit, :show]
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
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @profile.destroy
    session[:current_profile_id] = nil
    redirect_to root_path
  end

  def switch
    session[:current_profile_id] = params[:format]
    redirect_to request.referer
  end
  
  private
  def profile_params
    params.require(:profile).permit(:image, :name, :text).merge(user_id: current_user.id)
  end

  def set_profiles
    @profiles = current_user.profiles.all
  end

  def set_profile
    @profile = Profile.find(params[:id])
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

class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profiles
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def index
    @sounds = Sound.all.order('created_at DESC').includes(:profile, comments: :profile)
    @profile = nil
  end

  def new
    @profile = Profile.new
  end
  
  def create
    @profile = Profile.new(profile_params)
    if @profile.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @sounds = Sound.all.order('created_at DESC').includes(:profile, comments: :profile)
  end

  def edit
  end

  def update
    if @profile.update(profile_params)
      redirect_to profile_path(@profile.id)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    profile.destroy
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

end

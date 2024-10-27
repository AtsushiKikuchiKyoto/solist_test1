class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def index
    @sounds = Sound.all.order('created_at DESC').includes(:profile, comments: :profile)
    @profiles = current_user.profiles.all
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
    @profile = Profile.find(params[:id])
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    profile = Profile.find(params[:id])
    profile.update(profile_params) 
  end

  def destroy
    profile = Profile.find(params[:id])
    profile.destroy
  end
  
  private
  def profile_params
    params.require(:profile).permit(:image, :name, :text).merge(user_id: current_user.id)
  end
end

class SoundsController < ApplicationController
  before_action :set_profiles, only:[:new, :edit, :update]
  before_action :set_profile, only:[]
  before_action :set_sound, only: [:show, :edit, :update, :destroy]
  before_action :set_current_profile, only: [:new, :edit, :update]

  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(sound_params)
    if @sound.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end

  end

  def edit
  end

  def update
    if @sound.update(sound_params)
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sound.destroy
    redirect_to root_path
  end

  private
  def sound_params
    params.require(:sound).permit(:text, :sound).merge(profile_id: params[:profile_id])
  end

  def set_profiles
    @profiles = current_user.profiles.all
  end

  def set_profile
    @profile = Profile.find(params[:profile_id])
  end

  def set_current_profile
    if session[:current_profile_id] == nil
      @current_profile = nil
    else
      @current_profile = Profile.find(session[:current_profile_id])
    end
  end

  def set_sound
    @sound = Sound.find(params[:id])
  end

end

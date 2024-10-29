class SoundsController < ApplicationController
  before_action :set_profiles
  before_action :set_profile
  before_action :set_sound, only: [:show, :edit, :update, :destroy]


  def new
    @sound = Sound.new
  end

  def create
    @sound = Sound.new(sound_params)
    if @sound.save
      redirect_to profile_path(params[:profile_id])
    else
      render :new, status: :unprocessable_entity
    end

  end

  def show
    @comments = Comment.all.order('created_at DESC').includes(:profile, :sound)
  end

  def edit
  end

  def update
    if @sound.update(sound_params)
      redirect_to profile_sound_path(params[:profile_id], params[:id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sound.destroy
    redirect_to profile_sound_path(params[:profile_id], params[:id])
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

  def set_sound
    @sound = Sound.find(params[:id])
  end

end

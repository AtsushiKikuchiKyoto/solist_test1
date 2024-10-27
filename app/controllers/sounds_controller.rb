class SoundsController < ApplicationController
  def index
    @sounds = Sound.all.order('created_at DESC').includes(:profile, comments: :profile)
    @profile = Profile.find(params[:profile_id])
    @comment = Comment.new
  end

  def new
    @sound = Sound.new
    @profile = Profile.find(params[:profile_id])
  end

  def create
    @sound = Sound.new(sound_params)
    @profile = Profile.find(params[:profile_id])
    if @sound.save
      redirect_to profile_sounds_path(params[:profile_id])
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @sound = Sound.find(params[:id])
    @profile = Profile.find(params[:profile_id])
  end

  def edit
    @sound = Sound.find(params[:id])
    @profile = Profile.find(params[:profile_id])
  end

  def update
    @sound = Sound.find(params[:id])
    @profile = Profile.find(params[:profile_id])
    if @sound.update(sound_params)
      redirect_to profile_sounds_path(params[:profile_id])
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    sound = Sound.find(params[:id])
    sound.destroy
    redirect_to profile_sounds_path(params[:profile_id])
  end

  private
  def sound_params
    params.require(:sound).permit(:text, :sound).merge(profile_id: params[:profile_id])
  end
end

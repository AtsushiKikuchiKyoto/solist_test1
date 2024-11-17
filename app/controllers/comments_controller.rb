class CommentsController < ApplicationController
  before_action :set_current_profile
  before_action :set_sound

  def create
    Comment.create(comment_params)
    flash[:success] = "コメントをしました。"
    respond_to do |format|
      format.turbo_stream #Rail search 'create.turbo_stream.erb'
      format.html { redirect_to request.referer }
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    flash[:info] = "コメントを削除しました。"
    comment.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referer }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(profile_id: session[:current_profile_id], sound_id: params[:sound_id])
  end

  def set_sound
    @sound = Sound.find(params[:sound_id])
  end

  def set_current_profile
    @current_profile = Profile.find(session[:current_profile_id])
  end
end

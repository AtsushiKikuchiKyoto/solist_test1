class CommentsController < ApplicationController
  before_action :set_current_profile
  before_action :set_sound
  before_action :hotwire

  def create
    Comment.create(comment_params)
    @i = params[:comment][:comment_index]
    flash[:success] = "コメントをしました。"
  end

  def destroy
    comment = Comment.find(params[:id])
    @i = params[:index]
    flash[:info] = "コメントを削除しました。"
    comment.destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(profile_id: session[:current_profile_id], sound_id: params[:sound_id])
  end

  def set_sound
    @sound = Sound.find(params[:sound_id])
  end

  def hotwire
    respond_to do |format|
      format.turbo_stream #Rail search 'action.turbo_stream.erb'
      format.html { redirect_to request.referer }
    end
  end
end

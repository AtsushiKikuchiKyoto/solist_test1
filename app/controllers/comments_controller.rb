class CommentsController < ApplicationController

  def create
    Comment.create(comment_params)
    flash[:success] = "コメントをしました。"
    redirect_to request.referer
  end

  def destroy
    comment = Comment.find(params[:id])
    flash[:info] = "コメントを削除しました。"
    comment.destroy
    redirect_to request.referer
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(profile_id: session[:current_profile_id], sound_id: params[:sound_id])
  end

end

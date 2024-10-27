class CommentsController < ApplicationController
  def create
    Comment.create(comment_params)
  end
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
  end
  private
  def comment_params
    params.require(:comment).permit(:text).merge(profile_id: params[:profile_id], sound_id: params[:sound_id])
  end
end

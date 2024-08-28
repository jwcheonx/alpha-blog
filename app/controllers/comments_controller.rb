class CommentsController < ApplicationController
  before_action :require_login, only: %i[create destroy]
  before_action :set_comment, :authorize, only: :destroy

  def create
    comment = Comment.new(comment_params) do |c|
      c.article_id = params[:article_id]
      c.author_id = current_user.id
    end

    flash.alert = 'Failed to add comment' unless comment.save
    redirect_to article_path(params[:article_id])
  end

  def destroy
    flash.alert = 'Failed to delete the comment' unless @comment.destroy
    redirect_to article_path(@comment.article_id)
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize
    return if @comment.author_id == current_user.id || current_user.admin?

    redirect_to article_path(@comment.article_id), alert: "Cannot delete other users' comments"
  end
end

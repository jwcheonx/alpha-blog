class CommentsController < ApplicationController
  before_action :require_login, only: :create

  def create
    comment = Comment.new(comment_params) do |c|
      c.article_id = params[:article_id]
      c.author_id = current_user.id
    end

    flash.alert = 'Failed to add comment' unless comment.save
    redirect_to article_path(params[:article_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

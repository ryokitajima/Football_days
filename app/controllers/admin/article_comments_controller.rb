class Admin::ArticleCommentsController < ApplicationController
  before_action :authenticate_admin!

  def destroy
    ArticleComment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    redirect_to request.referer
  end

  private
  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end
end


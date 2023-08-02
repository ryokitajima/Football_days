class Public::ArticleCommentsController < ApplicationController
  before_action :authenticate_user!
  
  # 記事に対するコメントを作成するアクション
  def create
    # コメントを投稿する対象の記事を取得
    @article = Article.find(params[:article_id])
    # ログインしているユーザーに紐づく新しいコメントを作成
    @comment = current_user.article_comments.new(article_comment_params)
    # コメントに記事IDを紐づける
    @comment.article_id = @article.id
    # コメントを保存
    @comment.save
    # 元のページにリダイレクト
    redirect_to request.referer
  end
  
  # 記事に対するコメントを削除するアクション
  def destroy
    # 削除対象のコメントを検索して削除
    ArticleComment.find_by(id: params[:id], article_id: params[:article_id]).destroy
    # 元のページにリダイレクト
    redirect_to request.referer
  end

  private
  # ストロングパラメータを定義
  def article_comment_params
    params.require(:article_comment).permit(:comment)
  end
end

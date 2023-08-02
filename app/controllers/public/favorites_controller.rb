class Public::FavoritesController < ApplicationController
  before_action :authenticate_user! 
  
  # お気に入り記事一覧を表示するアクション
  def index
    # ログインユーザーのお気に入り記事のIDを取得
    @favorite_article_ids = current_user.favorites.pluck(:article_id)
    # お気に入り記事のレコードを取得
    @favorite_articles = Article.where(id: @favorite_article_ids)
  end
  
  # 記事をお気に入りに追加するアクション
  def create
    # お気に入りに追加する対象の記事を取得
    @article = Article.find(params[:article_id])
    # Favoriteモデルにお気に入り情報を作成
    @favorite = Favorite.new(user_id: current_user.id, article_id: params[:article_id])
    @favorite.save
    # 元のページにリダイレクト
    redirect_to request.referer
  end
  
  # 記事をお気に入りから削除するアクション
  def destroy
    # お気に入りから削除する対象の記事を取得
    @article = Article.find(params[:article_id])
    # ログインユーザーのお気に入り情報を検索して削除
    @favorite = current_user.favorites.find_by(article_id: @article.id)
    @favorite.destroy
    # 元のページにリダイレクト
    redirect_to request.referer
  end
end

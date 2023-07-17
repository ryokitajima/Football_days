class Public::FavoritesController < ApplicationController
  before_action :authenticate_user! # ログインしているユーザーのみアクセス可能にする
  
  def index
    @favorite_article_ids = current_user.favorites.pluck(:article_id)
    @favorite_articles = Article.where(id: @favorite_article_ids)
  end
  
  def create
    @article = Article.find(params[:article_id])
    @favorite = Favorite.new(user_id: current_user.id, article_id: params[:article_id])
    @favorite.save
    redirect_to request.referer
  end

  def destroy
    @article = Article.find(params[:article_id])
    @favorite = current_user.favorites.find_by(article_id: @article.id)
    @favorite.destroy
    redirect_to request.referer
  end

end

class Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin!
  
  # 記事一覧を表示するアクション
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  # 記事の詳細を表示するアクション
  def show
    @article = Article.find(params[:id])
    @user = @article.user
    @article_comment = ArticleComment.new
  end
  
  # 記事の編集フォームを表示するアクション
  def edit
    @article = Article.find(params[:id])
  end
  
  # 記事の更新を行うアクション
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to admin_article_path(@article.id)
  end
  
  # 記事の削除を行うアクション
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path
  end
  
  private
  # ストロングパラメータを定義
  def article_params
    params.require(:article).permit(:title, :body)
  end
end

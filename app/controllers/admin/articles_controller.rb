class Admin::ArticlesController < ApplicationController
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def show
    @article = Article.find(params[:id])
    @user = @article.user
    @article_comment = ArticleComment.new
  end
  
  def edit
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to admin_article_path(@article.id)
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to admin_articles_path
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
end

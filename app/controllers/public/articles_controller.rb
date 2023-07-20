class Public::ArticlesController < ApplicationController
before_action :is_matching_login_article, only: [:edit, :update, :destroy, :create]
  def new
    @article = Article.new
  end
  
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.save
    redirect_to articles_path
  end
  
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
    redirect_to article_path(@article.id)
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
  private
  def article_params
    params.require(:article).permit(:title, :body)
  end
  def is_matching_login_article
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to articles_path
    end
  end
end

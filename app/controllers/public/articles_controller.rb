class Public::ArticlesController < ApplicationController
before_action :is_matching_login_article, only: [:edit, :update, :destroy]
  # 新しい記事を作成するためのアクション
  def new
    @article = Article.new
  end
  
  # 記事を作成するためのアクション
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    if @article.save
      redirect_to article_path(@article)
    else
      render :new
    end
  end
  
  # 記事一覧を表示するためのアクション
  def index
    @articles = Article.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  # 記事の詳細を表示するためのアクション
  def show
    @article = Article.find(params[:id])
    @user = @article.user
    @article_comment = ArticleComment.new
  end
  
  # 記事の編集フォームを表示するためのアクション
  def edit
    @article = Article.find(params[:id])
  end
  
  # 記事の更新を行うためのアクション
  def update
    @article = Article.find(params[:id])
    @article.update(article_params)
    redirect_to article_path(@article.id)
  end
  
  # 記事を削除するためのアクション
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to articles_path
  end
  
  private
  
  # ストロングパラメータを定義
  def article_params
    params.require(:article).permit(:title, :body)
  end
  
  # 記事がログインユーザーによって作成されたものかをチェック
  def is_matching_login_article
    @article = Article.find(params[:id])
    unless @article.user == current_user
      redirect_to articles_path
    end
  end
end

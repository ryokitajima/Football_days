class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  
  # ユーザー一覧を表示するアクション
  def index
    @users = User.page(params[:page]).per(10)
  end
  
  # ユーザーの詳細情報と投稿記事一覧を表示するアクション
  def show
    @user = User.find(params[:id])  
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  # ユーザー情報の編集フォームを表示するアクション
  def edit
    @user = User.find(params[:id])
  end
  
  # ユーザー情報の更新を行うアクション
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path(@user)
  end

  private
  # ストロングパラメータを定義
  def user_params
    params.require(:user).permit(:name, :email, :image, :is_deleted)
  end
end


class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :unsubscribe, :withdrawal]
  before_action :ensure_guest_user, only: [:edit]
  
  # マイページを表示するアクション
  def show
    @user = User.find(params[:id])  
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  # ユーザー情報の編集画面を表示するためのアクション
  def edit
    @user = User.find(params[:id])
  end
  
  # ユーザー情報を更新するためのアクション
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  # ユーザー退会画面を表示するためのアクション
  def unsubscribe
  end
  
  # ユーザーの退会処理を行うアクション
  def withdrawal
  @user = current_user
  @user.update(is_deleted: true)
  reset_session
  redirect_to root_path
  end
  
  private
  
  # ストロングパラメータを定義
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
  
  # ログインユーザーと編集対象ユーザーが一致するかを確認するメソッド
  def is_matching_login_user
    @user = User.find(params[:id])
    unless user_signed_in? && current_user.id == params[:id].to_i
      redirect_to root_path
    end
  end
  
  # ゲストユーザーがプロフィール編集画面に遷移できないようにするメソッド
  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end  
end

class Public::UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update, :unsubscribe, :withdrawal]
  def show
    @user = User.find(params[:id])  
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  def unsubscribe
  end
  
  def withdrawal
  @user = current_user
  @user.update(is_deleted: true)
  reset_session
  redirect_to root_path
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
  def is_matching_login_user
    @user = User.find(params[:id])
    unless user_signed_in? && current_user.id == params[:id].to_i
      redirect_to root_path
    end
  end
end

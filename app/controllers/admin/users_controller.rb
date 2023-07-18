class Admin::UsersController < ApplicationController
  def index
    @users = User.page(params[:page]).per(10)
  end
 
  def show
    @user = User.find(params[:id])  
    @articles = @user.articles.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end


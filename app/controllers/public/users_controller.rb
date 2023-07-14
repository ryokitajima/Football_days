class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])  
    @articles = @user.articles
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(current_user)
  end
  
  def unsubscribe
  end
  
  def withdrawal
    @user = current_uder
    @user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :image)
  end
end

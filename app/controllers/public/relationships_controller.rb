class Public::RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user)
		redirect_to request.referer
  end
  
  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user)
		redirect_to request.referer
  end
  
  def followings
    @user = User.find(params[:user_id])
		@users = @user.followings
  end

  def followers
    @user = User.find(params[:user_id])
		@users = @user.followers
  end
  
  def timeline
    @user = current_user
    # フォローしているユーザーのIDを取得
    followed_user_ids = @user.followings.pluck(:id)
    # フォローしているユーザーと自分自身の投稿を取得して結合し、作成日時で降順に並べる
    @articles = Article.where(user_id: followed_user_ids + [@user.id]).order(created_at: :desc).page(params[:page]).per(10)
  end

end

  

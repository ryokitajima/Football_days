class Admin::RelationshipsController < ApplicationController
  before_action :authenticate_admin!
  
  # ユーザーのフォローしているユーザー一覧を表示するアクション
  def followings
    @user = User.find(params[:user_id])
		@users = @user.followings
  end

  # ユーザーのフォロワー一覧を表示するアクション
  def followers
    @user = User.find(params[:user_id])
		@users = @user.followers
  end
end

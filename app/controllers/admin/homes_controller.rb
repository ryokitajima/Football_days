class Admin::HomesController < ApplicationController
  before_action :authenticate_admin! # ログインしているユーザーのみアクセス可能にする
  def top
    @articles = Article.order(created_at: :desc).page(params[:page]).per(10)
  end
end

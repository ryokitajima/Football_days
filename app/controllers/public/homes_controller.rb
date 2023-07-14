class Public::HomesController < ApplicationController
  def top
    @articles = Article.page(params[:page]).per(10)
  end
end

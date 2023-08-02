class Public::HomesController < ApplicationController
  
  # topページを表示するための
  def top
    @articles = Article.order(created_at: :desc).limit(5)
  end
end

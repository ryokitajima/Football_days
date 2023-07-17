class Public::HomesController < ApplicationController
  def top
    @articles = Article.order(created_at: :desc).limit(5)
  end
end

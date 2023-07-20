class Article < ApplicationRecord
  belongs_to :user
  has_many :article_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.search_for(content, method)
      Article.where('title LIKE ?', '%'+content+'%')
  end
end

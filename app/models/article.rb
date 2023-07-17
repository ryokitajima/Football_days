class Article < ApplicationRecord
  belongs_to :user
  has_many :article_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  def self.search_for(content, method)
    if method == 'perfect'
      Article.where(title: content)
    elsif method == 'forward'
      Article.where('title LIKE ?', content+'%')
    elsif method == 'backward'
      Article.where('title LIKE ?', '%'+content)
    else
      Article.where('title LIKE ?', '%'+content+'%')
    end
  end
end

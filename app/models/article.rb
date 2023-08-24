class Article < ApplicationRecord
  belongs_to :user
  has_many :article_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  validates :title, presence: true
  validates :body, presence: true
  
  # 特定のユーザーがこの記事をお気に入りに追加しているかどうかを判定
  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
  
  # タイトルに指定された内容を含む記事を検索
  # content: 検索する内容
  # method: 検索方法 
  def self.search_for(content, method)
      Article.where('title LIKE ?', '%'+content+'%')
  end
end

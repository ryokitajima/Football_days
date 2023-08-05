class Favorite < ApplicationRecord
  belongs_to :user
  belongs_to :article
  # 記事ごとにユーザーが一意のお気に入りを持つことを検証します。
  validates_uniqueness_of :article_id, scope: :user_id
end

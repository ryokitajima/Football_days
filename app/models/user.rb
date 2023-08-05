class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # ユーザーのメールアドレスは一意である必要があります。
  validates :email, uniqueness: true
  # ユーザー名は一意である必要があります。
  validates :name, uniqueness: true
  
  # 画像をアップロードできるようにするための関連付け
  has_one_attached :image
  
  has_many :articles, dependent: :destroy
  has_many :article_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  # 自分がフォローされる（被フォロー）側の関係性
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # 被フォロー関係を通じて参照→自分をフォローしている人
  has_many :followers, through: :reverse_of_relationships, source: :follower

  # 自分がフォローする（与フォロー）側の関係性
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # 与フォロー関係を通じて参照→自分がフォローしている人
  has_many :followings, through: :relationships, source: :followed
  
  # 画像を取得するメソッド
  def get_image(width, height)
    # 画像が添付されていない場合、デフォルト画像を添付
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      # 指定されたサイズにリサイズした画像を返します
      image.variant(resize_to_limit:[width, height]).processed
  end
  
  # ユーザーをフォローするメソッド
  def follow(user)
    relationships.create(followed_id: user.id)
  end

  # ユーザーのフォローを解除するメソッド
  def unfollow(user)
    relationships.find_by(followed_id: user.id).destroy
  end

  # 特定のユーザーをフォローしているかを判定するメソッド
  def following?(user)
    followings.include?(user)
  end

  # ユーザー名で検索するためのメソッド
  def self.search_for(content, method)
      User.where('name LIKE ?', '%' + content + '%')
  end
  
  # ゲストユーザーを作成または取得するメソッド
  def self.guest
    find_or_create_by!(name: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end
end


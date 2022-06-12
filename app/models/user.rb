class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy

  validates :name, presence: true
  validates :profile, length: { maximum: 200 }

  has_many :likes, dependent: :destroy
  has_many :liked_tweets, through: :likes, source: :tweet
  has_many :comments, dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  #追記したぞ
  has_many :skills, dependent: :destroy


  # フォローする側から中間テーブルへのアソシエーション
  has_many :relationships, foreign_key: :following_id
  # フォローする側からフォローされたユーザを取得する
  has_many :followings, through: :relationships, source: :follower

  # フォローされる側から中間テーブルへのアソシエーション
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: :follower_id
  # フォローされる側からフォローしているユーザを取得する
  has_many :followers, through: :reverse_of_relationships, source: :following



  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy


  mount_uploader :image, ImageUploader

  def already_liked?(tweet)
    self.likes.exists?(tweet_id: tweet.id)
  end

  # あるユーザが引数で渡されたuserにフォローされているか調べるメソッド
  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end


  def update_without_current_password(params, *options)
  params.delete(:current_password)
  if params[:password].blank? && params[:password_confirmation].blank?
    params.delete(:password)
    params.delete(:password_confirmation)
  end
  result = update_attributes(params, *options)
  clean_up_passwords
  result
  end

end

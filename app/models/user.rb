class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :group_users
  has_many :groups, through: :group_users
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # ① フォローしている人取得(Userのfollowerから見た関係)
  has_many :followings, through: :relationships, source: :followed
  # 自分がフォローしている人
  has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # ② フォローされている人取得(Userのfolowedから見た関係)
  has_many :followers, through: :reverse_of_relationships, source: :follower
  # 自分をフォローしている人(自分がフォローされている人)
  
  attachment :profile_image
  # ユーザーをフォローする
  def follow(user_id)
    relationships.create(followed_id: user_id)
  end
  # ユーザーのフォローを外す
  def unfollow(user_id)
    relationships.find_by(followed_id: user_id).destroy
  end
  # フォロー確認をおこなう
  def following?(user)
    followings.include?(user)
  end
  
  
# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?","#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end

   validates :name, uniqueness: true, length: { minimum: 2, maximum: 20 }
   validates :introduction, length: { maximum: 50 }
end

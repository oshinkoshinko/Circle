class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_requests, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :event_members, dependent: :destroy
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following_member, through: :follower, source: :followed, dependent: :destroy
  has_many :follower_member, through: :followed, source: :follower, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :chat_rooms, dependent: :destroy

  def follow(member_id)
    follower.create(followed_id: member_id)
  end

  def unfollow(member_id)
    follower.find_by(followed_id: member_id).destroy
  end

  def following?(member)
    following_member.include?(member)
  end

  def active_for_authentication?
    super && (self.is_deleted == false)
  end

  #ゲストログイン用アクション
  def self.guest
    #null: falseをつけているカラムは下記で指定する
    find_or_create_by!(email: 'guest@example.com', name: 'guest', account_name: "ゲスト") do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end

  attachment :profile_image

end

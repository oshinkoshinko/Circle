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
  has_many :rooms, through: :chat_rooms
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  validates :name, presence: true
  validates :account_name, presence: true
  validates :password_confirmation, presence: true

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
    find_or_create_by!(email: 'guest1@example.com', name: 'guest', account_name: "ゲスト") do |member|
      member.password = SecureRandom.urlsafe_base64
    end
  end

  #通知機能(フォロー)
  def create_notification_follow!(current_member)
    temp = Notification.where(["visitor_id = ? and visited_id = ? and action = ? ",current_member.id, id, 'follow'])
    if temp.blank?
      notification = current_member.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  attachment :profile_image

end

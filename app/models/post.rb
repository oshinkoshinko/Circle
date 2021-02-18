class Post < ApplicationRecord

  belongs_to :member
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :post_requests, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :body, presence: true
  validates :address, presence: true

  #Google map表示用 経度緯度取得
  geocoded_by :address
  after_validation :geocode, if: :address_changed?

  #リクエスト機能　すでにリクエストされたかどうか
  def requested_by?(member)
    post_requests.where(member_id: member.id).exists?
  end

  #通知機能(リクエスト)
  def create_notification_request!(current_member)
    # すでにリクエストされているか検索 ?(プレースホルダー)で値を指定
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_member.id, member_id, id, 'request'])
    # リクエストされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_member.active_notifications.new(
        post_id: id,
        visited_id: member_id,
        action: 'request'
      )
      # 自分の投稿に対するリクエストの場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # #通知機能(リクエスト承認)できれば付けたい
  # def update_notification_request!(current_member)
  #   # すでに承認されているか検索 ?(プレースホルダー)で値を指定
  #   temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_member.id, member_id, id, 'accept'])
  #   # リクエストされていない場合のみ、通知レコードを作成
  #   if temp.blank?
  #     notification = current_member.active_notifications.new(
  #       post_id: id,
  #       visited_id: member_id,
  #       action: 'accept'
  #     )
  #     # 自分の投稿に対するリクエストの場合は、通知済みとする
  #     if notification.visitor_id == notification.visited_id
  #       notification.checked = true
  #     end
  #     notification.save if notification.valid?
  #   end
  # end

  #通知機能(コメント)
  def create_notification_comment!(current_member, post_comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = PostComment.select(:member_id).where(post_id: id).where.not(member_id: current_member.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_member, post_comment_id, temp_id['member_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment!(current_member, post_comment_id, member_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_member, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_member.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end

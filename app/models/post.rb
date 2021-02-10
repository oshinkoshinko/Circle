class Post < ApplicationRecord

  belongs_to :member
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :post_requests, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def requested_by?(member)
    post_requests.where(member_id: member.id).exists?
  end

end

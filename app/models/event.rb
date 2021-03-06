class Event < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  has_many :event_members, dependent: :destroy

  validates :name, presence: true, length: { maximum: 20 }
  validates :content, presence: true, length: { maximum: 200 }
  validates :place, presence: true
  validates :fee, presence: true
  validates :started_at, presence: true, uniqueness: { scope: :member_id }
  validates :finished_at, presence: true
  validates :expired_at, presence: true
  validates :genre_id, presence: true

  def applied_by?(member)
    event_members.where(member_id: member.id).exists?
  end

  attachment :event_image

end

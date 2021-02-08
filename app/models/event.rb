class Event < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  has_many :event_members, dependent: :destroy

  def applied_by?(member)
    event_members.where(member_id: member.id).exists?
  end

  attachment :event_image

end

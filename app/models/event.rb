class Event < ApplicationRecord
  belongs_to :member
  belongs_to :genre
  has_many :event_members, dependent: :destroy

  attachment :event_image

end

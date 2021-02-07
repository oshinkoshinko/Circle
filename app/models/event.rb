class Event < ApplicationRecord
  belongs_to :member
  has_many :event_members, dependent: :destroy

  attachment :event_image

end

class EventMember < ApplicationRecord
  belongs_to :event
  belongs_to :member

  validates :feedback, presence: true, on: :update, length: { maximum: 140 }

end

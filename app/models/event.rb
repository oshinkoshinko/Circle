class Event < ApplicationRecord
  belongs_to :member
  has_many :event_members, dependent: :destroy
end

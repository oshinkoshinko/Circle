class Room < ApplicationRecord
  has_many :chat_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :members, through: :chat_rooms
end

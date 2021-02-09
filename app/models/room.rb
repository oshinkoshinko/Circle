class Room < ApplicationRecord
  has_many :chat_rooms
  has_many :chats
end

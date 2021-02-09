class Room < ApplicationRecord
  has_many :chat_rooms, dependent: :destroy
  has_many :chats, dependent: :destroy
end

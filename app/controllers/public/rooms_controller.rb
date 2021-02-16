class Public::RoomsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def index
    #ログインユーザが存在するchat_roomを取得
    @chat_rooms = ChatRoom.where(member_id: current_member.id)
    # @all_rooms = ChatRoom.where
    # #@chats = @chat_rooms.room.chats
    # #ログインユーザが持つroomを取得
    # @rooms = @chat_rooms.pluck(:room_id)
    # #ログインユーザが存在するroomの中のメッセージを取得
    # @room_chats = Chat.where(room_id: @rooms).order("created_at DESC")

    # @room_members = ChatRoom.where(room_id: @rooms)
    # #binding.pry
    # #@rooms = Room.where(id: @chats.room_id)

    @rooms = current_member.rooms

  end

end

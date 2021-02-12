class Public::ChatsController < ApplicationController

  def show
    @member = Member.find(params[:id])
    rooms = current_member.chat_rooms.pluck(:room_id)
    chat_rooms = ChatRoom.find_by(member_id: @member.id, room_id: rooms)

    unless chat_rooms.nil?
      @room = chat_rooms.room
    else
      @room = Room.new
      @room.save
      ChatRoom.create(member_id: current_member.id, room_id: @room.id)
      ChatRoom.create(member_id: @member.id, room_id: @room.id)
    end
    @chats = @room.chats
    @chat = Chat.new(room_id: @room.id)
  end

  def create
    @chat = current_member.chats.new(chat_params)
    if @chat.save
      redirect_to request.referer
    else
      redirect_to request.referer
    end
    #binding.pry
  end

  def destroy
  end

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end

class Public::ChatsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

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
    @chat.save
    @chats = Chat.where(room_id: @chat.room_id)
  end

  def destroy
  end

  def correct_member
    @chat = Chat.find(params[:id])
    @member = Member.find_by(id: @chat.member.id)
    if @member != current_member
    redirect_to root_path
    end
  end

  private

  def chat_params
    params.require(:chat).permit(:message, :room_id)
  end
end

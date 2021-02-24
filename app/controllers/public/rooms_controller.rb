class Public::RoomsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def index
    # メッセージが新しい順でroomを取り出す
    @rooms = current_member.rooms.includes(:chats).order("chats.created_at DESC")
  end

end

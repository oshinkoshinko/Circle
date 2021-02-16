class Public::RoomsController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def index
    @rooms = current_member.rooms.order("created_at DESC")
  end

end

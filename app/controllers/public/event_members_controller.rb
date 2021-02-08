class Public::EventMembersController < ApplicationController

  def new
    @event = Event.find(params[:event_id])
    @event_member = EventMember.new
  end

  def create
    @event_member = EventMember.new(event_member_params)
    @event_member.save
    redirect_to event_event_members_complete_path
  end

  def complete
  end

  def event_member_params
    params.require(:event_member).permit(:member_id, :event_id, :feedback, :rate)
  end

end

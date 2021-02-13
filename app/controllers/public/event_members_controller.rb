class Public::EventMembersController < ApplicationController
  before_action :authenticate_member!,except: [:top]

  def new
    @event = Event.find(params[:event_id])
    @event_member = EventMember.new
  end

  def create
    @event_member = EventMember.new(event_member_params)
    @event_member.save
    redirect_to event_event_members_complete_path
  end

  #フィードバック投稿フォーム
  def show
    @event = Event.find(params[:event_id])
    @event_member = EventMember.find(params[:id])
  end

  def update
    @event_member = EventMember.find(params[:id])
    @event_member.update(event_member_params)
    redirect_to events_myevent_path
  end

  def destroy
    @event_member = EventMember.find(params[:id])
    @event_member.member.id = current_member.id
    @event_member.destroy
    redirect_to events_myevent_path
  end

  def complete
  end

  def event_member_params
    params.require(:event_member).permit(:member_id, :event_id, :feedback, :rate)
  end

end

class Public::EventMembersController < ApplicationController
  before_action :authenticate_member!,except: [:top]
  before_action :correct_member, only: [:show]

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
    @event_member.score = Language.get_data(event_member_params[:feedback])
    if @event_member.update(event_member_params)
      redirect_to event_path(@event_member.event_id)
    else
      @event = Event.find(params[:event_id])
      render 'show'
    end
  end

  def destroy
    @event_member = EventMember.find(params[:id])
    @event_member.member.id = current_member.id
    @event_member.destroy
    redirect_to events_myevent_path
  end

  def complete
  end

  def correct_member
    @event_member = EventMember.find(params[:id])
    @member = Member.find_by(id: @event_member.member.id)
    if @member != current_member
    redirect_to root_path
    end
  end

  def event_member_params
    params.require(:event_member).permit(:member_id, :event_id, :feedback, :score)
  end

end

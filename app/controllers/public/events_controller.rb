class Public::EventsController < ApplicationController

  def index
    @events = Event.all.limit(5).order("created_at DESC")
    @genres = Genre.all
  end

  def new
    @event = Event.new
    @genres = Genre.all
  end

  def create
    @event = Event.new(event_params)
    @event.member_id = current_member.id
    @event.save
    redirect_to events_myevent_path
  end

  def edit
    @event = Event.find(params[:id])
    @genres = Genre.all
  end

  def update
    @event = Event.find(params[:id])
    @event.update(event_params)
    redirect_to events_myevent_path
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_myevent_path
  end

  def show
    @event = Event.find(params[:id])
    @event_members = EventMember.where(event_id: @event.id)
  end

  def myevent
    #参加予定イベント取得
    @join_events = EventMember.where(member_id: current_member.id)
    #ログインユーザの開催予定イベント取得
    @active_events = Event.where(member_id: current_member.id, is_finished: false)
    #ログインユーザの開催済みイベント取得
    @finished_events = Event.where(member_id: current_member.id, is_finished: true)
  end

  private

  def event_params
    params.require(:event).permit(
      :name,
      :content,
      :place,
      :event_image_id,
      :fee,
      :is_finished,
      :started_at,
      :finished_at,
      :expired_at,
      :member_id,
      :genre_id)
  end

end

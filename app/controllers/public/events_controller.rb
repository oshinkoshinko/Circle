class Public::EventsController < ApplicationController

  def index
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

  def myevent
    @events = Event.where(member_id: current_member.id)
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

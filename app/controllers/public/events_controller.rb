class Public::EventsController < ApplicationController

  def index
  end

  def new
    @event = Event.new
    @genres = Genre.all
  end

  def create
    @event = Event.new(event_params)
    @event.save
    redirect_to events_myevent_path
  end

  def myevent
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
